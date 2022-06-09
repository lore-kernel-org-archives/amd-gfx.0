Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B98BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jun 2022 14:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 930B3112FD2;
	Thu,  9 Jun 2022 14:43:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADB5C1123D6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jun 2022 14:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayyGY6/RkZlMWXFqlCzira245ro9VeBYO/n38gnJwPBZ/2pzjr4HzU0YCOicpz+3U2m42rwKnQnZhxUH/egCib8O/mhHRNEW0N8ClCz6g9FpAojBE5XXtb/t1cUuilKBA/SIr6I86YfhANBJHEgXHwUqjDWc03LSbwKON02wGePDdNfN1+/PYY39JPd2olAbq0ECK+bDAgnLMhIuS7eaCRhER5PsQu1rB66/m8Lb/5XVz5Fy9sxLgyXwTfBnDlxnuDnYGYtJjN3JfFWTBNwgSSr6AlIt1G2MbPA9/GiuTFRVvZ9S/CPaprufJYK7F/ng9UigrTy+180Ni3oxRJPtLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2VBd8NJYOZ3HAWEo9fP8+20IgfDj1kqY7QBrA1Z4hk=;
 b=bIG5Ww5/OefTBo0vRGBK8Q6Xx15wiiawQunYoCJxBepRrplsbJxu04CaV+9ejv8oHcJ82K9jl5w0rFdv5rUpX2IYK6WZvn3Sme3CBm5S1+j4NMLew9MMYR8RKbr66OD91QiTQaAX1wi2R6VS3/CebQ1VxJKlU7aBtOkNoVtzOx5DURgbjQs7b7mrqDI/JfT0xrPs1VgJzeBpBObgHwEctqtaTxBEr0Z9D+053GI5cvPoF7m6ETXZ7/v+dw1gxoBtnAlZvSJP3o44tqGUZAZia4vucn0GhktfXSJjf3+EHePbLFlBXyxR5vpr6SD6nKmlD3TOktnFcZ5cFldBjy2RgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2VBd8NJYOZ3HAWEo9fP8+20IgfDj1kqY7QBrA1Z4hk=;
 b=q/m0eJmBTLsxIKKoUuBwkfwym7PB+l8mkDbFq6qaKWcdR1GKJhdAE9sQ6ejdrvHy+ona/bT6lRYB7eax1kqG8ec4CnfqWq7z4xkGyM0zG50HtD0vCeNR6OWsjW+Kl+HI5vQZmMtXTokdzWTueOCmx0DzglbW6ITqtXeptv/cry8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BYAPR12MB3144.namprd12.prod.outlook.com (2603:10b6:a03:d6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 9 Jun
 2022 14:43:41 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba%6]) with mapi id 15.20.5332.014; Thu, 9 Jun 2022
 14:43:41 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/discovery: enable vcn/jpeg v4_0_2
Thread-Topic: [PATCH] drm/amdgpu/discovery: enable vcn/jpeg v4_0_2
Thread-Index: AQHYe+7AsDLeDHbES0i6uJRiRNSNUK1HJqus
Date: Thu, 9 Jun 2022 14:43:41 +0000
Message-ID: <BL1PR12MB5144AFC679D0BA40A8600487F7A79@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220609104909.2163905-1-yifan1.zhang@amd.com>
In-Reply-To: <20220609104909.2163905-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-09T14:43:40.839Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d5de2c5-d7e0-4760-7b2f-08da4a267271
x-ms-traffictypediagnostic: BYAPR12MB3144:EE_
x-microsoft-antispam-prvs: <BYAPR12MB3144B32D183959F3B693F6EDF7A79@BYAPR12MB3144.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ky60eeSj9Am19ucpEQ7Z/FkDCFQRFYUzSzeDflhKH+TpIVsJBoh3Eu1YKXUmaUthisZ2M+d2nC4wBVdXRFKobND0HX/uze0kL/eE0yQ14s5yr+72nQtsXFKfugbqfwRQYFetnlLIOax6vK6rQt99bnD2gSFckhwBZSim3wN0spDB6BnyTFcT+Dink8bGi3iAVT/XNPoasMzG9t3n7Vpss494Rbc8zHHDlSHz8ewjvFjDsyHU7ibiiOaEZ+ZDcu+aPwvlyTt+Zu48RJv23QQ0I/fGvtWnt/2nBP+lG7Lp3xBLbyFvxPJh9Wg14ZqIQ/T7yG+Q5jLIYZ9k4FuwkfGFY4LS+rttXxsuMHM8quRfHs4qj/Dgim8lEcJq3sjaujHPlU8K+BkXTO37CZ9C3aRWxg/Mf/RUNdJJ+wSfEpPes5BpGCgBHVOIlkah4QcNC/X8s+Sv1K+xo8ADnQ7LoP4thmUja1DT5N8vm6pFdrckg535jUyvlyb2lzezZnpv2hUgQ/x+K2eLRBpujz1hMeD1pWPgkgYAmP3i1s9RgN9mpwAFIUKKnTt9z9ZeZZcUCmpz9tfdtvm77/Q1Ki9Gzxm10zT2Qz7nE3atGQADdJ7fEXvmwB9YMKrEBpGnZkSi50b/31VL8Nl2kgQx7ZqHKAX8w50Krf89NfPXODsv18Q76l8F5rNnbtHkGMDFEmBKr0/CocmYhL4kDvUxkT/uRbf5VMIqlPf/UivOHoqh9k8vFZeLtEivD4C1nqNTuMai/u89
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(38070700005)(186003)(53546011)(110136005)(71200400001)(2906002)(508600001)(52536014)(55016003)(9686003)(8936002)(54906003)(26005)(38100700002)(86362001)(19627405001)(33656002)(316002)(7696005)(6506007)(122000001)(66556008)(4326008)(8676002)(5660300002)(66476007)(76116006)(66446008)(66946007)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cT5kmQ1hvZd2SBkD1WONNaZrgVGMQZMkZ1wZ7IwmxOYj047yAFtssuS3Mnof?=
 =?us-ascii?Q?SOTDtPnOnHKsaR/saNaI2rcsTNryzuwBSHGT1PxDxHu7lQ4NiiaPuwXXBnlf?=
 =?us-ascii?Q?FOoTRVC5/fI7GSlXoPaUIqX5qA51v3DLPEmC7QpnA1xYiLuv7u9CZnVT73G0?=
 =?us-ascii?Q?yuUHd1PdhdI43WnUyPCTg8krSm2cFn8W9oTHnP/U39ipqa4DVjtz8QuScij2?=
 =?us-ascii?Q?qSFsXZDb65XHvvV8Bv06t0jlyPEgpCOUqeBUD3TPiazgarXUj47FrmHes7fV?=
 =?us-ascii?Q?1nEcOaeYxs0nzGUgK/hj0N/2s6X7ui5Pr7Enw3w5UCeLPc0Sy1Q/e5iR+eG9?=
 =?us-ascii?Q?2C5r8yFqmbAcmdec85UR6vNyuPlEoSpaPYsSN3HTaY1I22mU5ItYzkh9mg4b?=
 =?us-ascii?Q?eBBE3ut8XmiH11ZEY95Pp7Qg5DQ2i9ZZjqLK+pMwRmUKx6qNtUPPDctmBSwz?=
 =?us-ascii?Q?ls7maCHpmkSd31RqyOxE0ZXpSN6GjdQnjvmKYcOq7Yaxl0Uj+hhNr1xa+IDl?=
 =?us-ascii?Q?f8F8HPuptnu4CSnD9p6yczrxcbG9Sg17Uzc1jsz7+TWKrulj3BE7b5T1bknV?=
 =?us-ascii?Q?09ATxFELP3yqpt9N3+/SuqaEUYCsNM6wQXTvlaTOVStz8Wy7a/ggp59IEbFU?=
 =?us-ascii?Q?FbCYUAklutlcUvOvQFs8fUUJOhZ9edF3ZfB/MO6IhMpxd/suEr3h8rs7qK5a?=
 =?us-ascii?Q?fds05L95yYTczesaZjT3xYudcSKdUo+xtpf9EQ9eUTL+NZiDUJmX3/pSB1Ax?=
 =?us-ascii?Q?fRf2eOd7ecy/ZcDrhDlYI71OXc8p+usGiPH5oZoD43585M4fGfuGz5TzM8wn?=
 =?us-ascii?Q?SoI21VNYiM0C3uWgw42xgzixtCHj8ZgOdNApWYn7Pbttb3wLGhVQOR35qYvu?=
 =?us-ascii?Q?5CmuzBRfwSefFNd4sx1/gKWNa7UbMcs2wZmd8h4elZlfKBul6yXZWA2bvZS8?=
 =?us-ascii?Q?DJZyCNRRlV7jN7TnOudbCgALjE1SCqK7d8tdmfRXe6I5/m5XkvZ8wR684ZTR?=
 =?us-ascii?Q?plUavOp4ISHENka+NcgR73ltrgKsMNg/kvQJ+fEJibMqTXAD8AQJEqMLbtXp?=
 =?us-ascii?Q?3Y4QtkPhnU7QWhhHLUKIyTG+5R5W+oH07TW9pWK/ivog0k2JQNVywN3jfV9s?=
 =?us-ascii?Q?43NSdPwviwePEODFTFGN4XEBGEnYnTtlKLsjdTip57/OEjzJ0zZD3le1XTrn?=
 =?us-ascii?Q?Ye0faDkCC7+h9kj69nlXCIYl7+3wrXVe2+m+si/2KQfNIodEnygbhNkUqH0j?=
 =?us-ascii?Q?CJEHUvRAuPM94VepRu0MGF4rzkCd/gXGS1yGZx3u2bWPBZFOECs6alQlrUIb?=
 =?us-ascii?Q?XDaJMRE4WAcup5LJajok4+F5jPYCbKyZJO8CSJ+3Qsnuj8HtZK8EC/yMHzEk?=
 =?us-ascii?Q?bTe91koGWa17F/fOA2rD+jE1dupJXs99Ip/vjgL51FJMYmM7TGAYmRryj/wo?=
 =?us-ascii?Q?aHHqr2S7tjocHT5O57OSJZdPHmXzpWImvtiqFvGXUs5nsrm2a+A5aj3OdQt2?=
 =?us-ascii?Q?4XBZDZFDt8oViQWxhv+qi0IgLQ1Y9bFzalwSiMCsrddvp/92VJW/RGGZfPfz?=
 =?us-ascii?Q?FrC+YmhIU2UPRNMrMKeZonjgQqKF70vm/SgqiFL8rYuux9DcIiNiJg2p4eQj?=
 =?us-ascii?Q?0TDzNZ5XS9UzNNArKpb1kuca5UQRNZJpG+nAEHenMbxFkuOWxbGJowrMBvpm?=
 =?us-ascii?Q?Hn7BNm9KxDyi3/5cPygu03m85UMW5g7Y6GEWN0cWecb0ZGBvYx++52ywC0Xb?=
 =?us-ascii?Q?j5xl14U6Ww=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144AFC679D0BA40A8600487F7A79BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5de2c5-d7e0-4760-7b2f-08da4a267271
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 14:43:41.3411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vj205m3uTVZze5UJaMug6P7oGzPxrAWJP9Al5telP5Lry/DpvrnjPw3ZtCKsrBDsI5qi2Nr2z0K2sIgpWhq/Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3144
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Huang, Tim" <Tim.Huang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144AFC679D0BA40A8600487F7A79BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Thursday, June 9, 2022 6:49 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com=
>
Subject: [PATCH] drm/amdgpu/discovery: enable vcn/jpeg v4_0_2

Enable vcn/jpeg 4_0_2.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 91f21b725a43..7dd098351a59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1888,6 +1888,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct a=
mdgpu_device *adev)
                         amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_bloc=
k);
                         break;
                 case IP_VERSION(4, 0, 0):
+               case IP_VERSION(4, 0, 2):
                 case IP_VERSION(4, 0, 4):
                         amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_bloc=
k);
                         amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_blo=
ck);
--
2.35.1


--_000_BL1PR12MB5144AFC679D0BA40A8600487F7A79BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Yifan &lt;Yifa=
n1.Zhang@amd.com&gt;<br>
<b>Sent:</b> Thursday, June 9, 2022 6:49 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; Deucher, Alexander &lt;Ale=
xander.Deucher@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;; Zhang, Yi=
fan &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/discovery: enable vcn/jpeg v4_0_2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Enable vcn/jpeg 4_0_2.<br>
<br>
Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index 91f21b725a43..7dd098351a59 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -1888,6 +1888,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct a=
mdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(adev, &amp;vcn_v3_0_ip_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 0):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(4, 0, 2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(adev, &amp;vcn_v4_0_ip_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(adev, &amp;jpeg_v4_0_ip_block);<br>
-- <br>
2.35.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144AFC679D0BA40A8600487F7A79BL1PR12MB5144namp_--
