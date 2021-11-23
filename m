Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3229C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Nov 2021 15:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCC76E209;
	Tue, 23 Nov 2021 15:02:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0BAD6E209
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 15:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/GYyibgmIfaU5tpJIe9jDKSjhGeWCo+xhG1U9Wok+QhdI+lLJx6Pm/ilCwHjWQCqftiDK+5bufHZcFPILuT7CQg7l65W1RP/w9sXYneYnYIYnUypIcIpZmJfZVvforP10EPFLE0gUak2Lbycozh01a2lvLdm6Ad7NqbTrKiuBpC8kF9EJ5yhH41foq4BZLSPnXzZzjhvYPC5MLtbfx25p8AiPElT9KXJWiWWvN9p9BtykNvsU9KYo/d6SYcpGnFpoXkx9rtXJcPGHFS2M88VmoSm3QDPzKLUNJH50XjaNdA6g7oIKllM2XkFuZdmTUVn1DryaKP7m67oqJ10k0dMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TD+O8birZ7EcIVYPvBzxdRMP1wCzmJVEVsmFzvn7RdU=;
 b=EJHlarefqkS9lluBpCvkUqMqSePDPgIybYLNa/lbV/ShWot74XY+bguXl1onb7IJUCsYFlEurgZfLTdT4RjMXPqpj14qutaNqeEUFBjzwg97lTPd7xvUeJDUNISttesc2p3E/z2zxtPmKM4hiHEyuRrEhhrAfEAIv3HZUwrO99KXhyuPXO9FdaR3w3xqX0GFIkzfWAVtn4RDzoQw06l7pThOGbWjlfWGL0BU7CLZZ0JYZAmvjl8Ma5L27iKgJD2awAADzXwS156b1CHCnJKJatkGjim6mT+UvzObPXZ53TPx4Ot0tEnNu3VN1+yAwZvkAlbCwBrfAntkOkHwfUmoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD+O8birZ7EcIVYPvBzxdRMP1wCzmJVEVsmFzvn7RdU=;
 b=3FKHC5vypP2IvDUvCF+fWhldRCVBMbIgvOC3sMTvG7YOHuTLpvGSGyIfE0tRabfGZ8n5oZZvKb2vP1F35Pz58gkG1/q+3PZQLARg8BZAx49L6/VgilOCfkhx65Yt8aS6szUHPkJaLNurGYl6+KjmoUZ2DtfoaSoJBmHGiZ0Molc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5554.namprd12.prod.outlook.com (2603:10b6:208:1cd::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 15:02:35 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830%8]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 15:02:35 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Jian, Jane" <Jane.Jian@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Chen, 
 JingWen" <JingWen.Chen2@amd.com>
Subject: Re: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip
 init for SIENNA_CICHLID
Thread-Topic: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip
 init for SIENNA_CICHLID
Thread-Index: AQHX4F4eqsL6/6OzcEGCfRNJJbAHJawRNUG1
Date: Tue, 23 Nov 2021 15:02:34 +0000
Message-ID: <BL1PR12MB514481ADF439A81349D03279F7609@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211123113438.5200-1-Jane.Jian@amd.com>
In-Reply-To: <20211123113438.5200-1-Jane.Jian@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-23T15:02:34.329Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 0cc8f3bc-5241-7c91-bcf9-e0a4ad744bbf
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e749b3e-460d-4022-062f-08d9ae924853
x-ms-traffictypediagnostic: BL0PR12MB5554:
x-microsoft-antispam-prvs: <BL0PR12MB5554C79AE7A9F988814A8006F7609@BL0PR12MB5554.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jvAZB1j6wszz9g/GE7+TxQALCLtpjT4mDYA77qFfUZfrbsdSwOJfh/sCannw+LDZGm6Kw01PTjZfaxGW9Gkce2lnODqxHtx5kcpbTWkUHHMuIXK8Y9eHbbxT++I5HkcJ+wc5Y3YLs034zkF7k7JIjlWwH3tG2f3zY+vo3xO/14bOnVpjPNQfhI02+r3+CrHWNwy4RXMK5z3mxGondyxP7HXr1+kCY2d/q1MJ3kppf6bSzQPJj2jPr8UyRxeJ/RCqQ33Yd9C4RuB+g1/rgC000uuc8Bmdk4MC923JDX/qAGavqyp/NkKU8eGlDEwiT+aV1V1kNWMHBhHW0qSeeUU0AuUgeEfgHR4jmdDMH+YWewW3WO86S0nFnBBChcPaAxjn3xjUxG3OS1ErRziILCLwQFAJrsbWfKVSIODfyPzsp4lcFzmWcbv+exeBdM7vvjXLi44ccHORzKIanUeS3xGrZiEdpP5nRd5TXHrkke2KEhyBkvgFcbnsm1lTfg/3+LLRmUfs+tBXbZp3/F4cdOa2GbY6f3FO6i4jMxzIWzBk7iI3J3hlIhCSDTkQbiXvJh22K2xpihNi0gI6EaqymZ4tecJN6b9gySStiNFYsykO58R1XGlfodV8VQyGDJZIMNp/2YXVW80aDoiAj3TngJ6nKwK9C03o4+AVkso1QTw2GMHZGDhfvjxye+7LLPKX9nCPu+Uxh0MTlPvvrruOPFut+A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(26005)(5660300002)(38070700005)(53546011)(110136005)(33656002)(186003)(83380400001)(8676002)(66446008)(6636002)(7696005)(38100700002)(2906002)(66556008)(64756008)(508600001)(55016003)(316002)(66476007)(19627405001)(66946007)(71200400001)(9686003)(76116006)(122000001)(52536014)(86362001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l+wLoRA3RbhqNxARZEzbwFPZ/d2gdckvPiZfjYm4G5aiV7K1av58MnoqRV+4?=
 =?us-ascii?Q?+mA7gaTZFPGbRgdTzicZ6TynmGIAdYEwOJFdGKVgWSTOiyC4Zg1jVcvEKsLN?=
 =?us-ascii?Q?sWQi0kjkcbSrmmBXrNL4daHTp+YvtZ7+kqRmFYxHZnyWJSzRyDcVweOw7Kzs?=
 =?us-ascii?Q?djlykvK46JIiy8zwXeg0kd3PyYQjoA68VDcslaSll35cuZ75LNwpyqmYVJC4?=
 =?us-ascii?Q?2x9cyS3Q0pVtdKhfHeWTHurVkXCb08lVZafPGE3L6/XchaEDjCvUV6vgC14O?=
 =?us-ascii?Q?oPYccuJxEwO4lAgsJQXM45S3QrilEvOzonWOimYgrHiMLwlUro+b47plnV1W?=
 =?us-ascii?Q?pdtF4lFmUEVN09Vp7JX2sL06dpRj5+6HKwELKHwSvfihxJNe92ZuozC2lZUx?=
 =?us-ascii?Q?GA0U4mzn+oBeoup94SaOy29stC2pMeWaM8eqCLulvXFUXUYnwYb34zijQ1od?=
 =?us-ascii?Q?BDa+hI1NzoO/w3D7gH7t81rByU6ID1SlqX26fINonDiHBi0Sj+xFXofqf6zU?=
 =?us-ascii?Q?hNLT/gyXW7HwUh2xdJHOxuKov+j8pFP+87pXEWExFFwWIJYJd7gIlOJp42VJ?=
 =?us-ascii?Q?ow0U3F53vLQu86uAL+DKhyKB9snVt+KdJjDGxif1nieoIXMojTPX8jevVyra?=
 =?us-ascii?Q?pPPZGUIdDRoSEIliyP7vhHRdjA16nzuju1gu+CumKOoG4zwZh+oq5J2fxTbb?=
 =?us-ascii?Q?O4dV1qNZ7gN7g3Jcw5Fgr+W2ZKdTTB5GyDbmHTG7rzpXHQSO4Cy3M4yRHpLG?=
 =?us-ascii?Q?TPxY45/sL0vbQwBq3vAXLrfo8+4MGnVASG5yHaGiGC5aJVIm5acKeULUnrkr?=
 =?us-ascii?Q?C2iIcAob/FL6y8IZRrXs4LjYEmbf97SnLvqeFOWGSYD+qQ16It3aybiSW8y/?=
 =?us-ascii?Q?BVjpYYGdJ9Vllbs3K5cweSHdRcp3igXbwMoHaMWauhLEwQgCu9AzW+XuETqC?=
 =?us-ascii?Q?u1NLlI+zagLUq/x0fr3zt8uOwHpKr+9TsjYjdoVN7anYL0STMlqNPgdzLJJK?=
 =?us-ascii?Q?GxOOiuPyNOOO4/nNWb4rrRq1U8CTS6ti2fc+Ce8ID8ptzXTwTtI74/seN/ui?=
 =?us-ascii?Q?ZhgEsXPYI+EBka9zYyEqiouCGnU4wMlpGJfxE1zZe1CRv89WQN5HWKOQfvmK?=
 =?us-ascii?Q?/LmhfYkqxclGfBy3/b1xFEtb9STEFeHjiIMIxvJekEMFUSQL8AshJvE7o6Wg?=
 =?us-ascii?Q?YNnyrk1/VkJNtSfWpeRgBE2CmstkmfGL0uGfCYSOat/YbBadxEdxhNvuNq6a?=
 =?us-ascii?Q?vp+oJ78SSN9QGG38zwxhE41VzpEQNVjCRC+Zl5h4lMb6FRkfGGBJLpxyJIsv?=
 =?us-ascii?Q?N2Ra2B7X/neqE+tFttjjEhRLFbHzE2GoCJD0XEvHOqpY8t/eryChcGryZtW8?=
 =?us-ascii?Q?XTa8EBRJF0i9lLlnt0XDPaLrh7F6PxVDYymrUitP2jRHEMeB+Vhpgpbrb7QB?=
 =?us-ascii?Q?RVDnRi7TKqPIouhkM/o3FNi7oWDIjBm+kdrrEdmMuyHLKJESyzbjI9LsDmXd?=
 =?us-ascii?Q?0A+jCAddakVW9K56jyewz6YgpjPHiwRNQQPofSBXR+Dt4j8yctEC7sqZZz/P?=
 =?us-ascii?Q?Sx0OW1t7KkpbNh3u85N+bhia8THddRUmKjowpy3bdQLwjV4p7aUlrivNME2R?=
 =?us-ascii?Q?x4w1HzPUM1X5pdQiwA2mk5U=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514481ADF439A81349D03279F7609BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e749b3e-460d-4022-062f-08d9ae924853
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 15:02:34.9931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERDBp4bvdip+jFWtS4MsCyp9bC7A2VrJYBF3E9i4XblRO3XiVvyQkJ/GrVhC/rGfuOxYBFuVxkFo96YsgZmMQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5554
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514481ADF439A81349D03279F7609BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Can we just add a check for the new IP version in that case?  This looks re=
ally hacky.

Alex

________________________________
From: Jane Jian <Jane.Jian@amd.com>
Sent: Tuesday, November 23, 2021 6:34 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>;=
 Chen, JingWen <JingWen.Chen2@amd.com>
Cc: Jian, Jane <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip in=
it for SIENNA_CICHLID

[WHY]
for sriov odd# vf will modify vcn0 engine ip revision(due to multimedia ban=
dwidth feature),
which will be mismatched with original vcn0 revision

[HOW]
skip ip revision match case and continue use asic type to check

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
Change-Id: I1ace32acbf3a13c0baac958508da1324ec387a58
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 4e3669407518..0a91e53f520c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1334,7 +1334,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_dev=
ice *adev)
                         return r;
         }

-       r =3D amdgpu_discovery_set_mm_ip_blocks(adev);
+       if (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID && amdgpu_sriov_vf(a=
dev))
+               r =3D amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
+       else
+               r =3D amdgpu_discovery_set_mm_ip_blocks(adev);
         if (r)
                 return r;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 4f7c70845785..87f56b61be53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -86,6 +86,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
         for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
                 atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);

+       if (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID && amdgpu_sriov_vf(a=
dev)) {
+               fw_name =3D FIRMWARE_SIENNA_CICHLID;
+               goto next;
+       }
         switch (adev->ip_versions[UVD_HWIP][0]) {
         case IP_VERSION(1, 0, 0):
         case IP_VERSION(1, 0, 1):
@@ -168,6 +172,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
                 return -EINVAL;
         }

+next:
+
         r =3D request_firmware(&adev->vcn.fw, fw_name, adev->dev);
         if (r) {
                 dev_err(adev->dev, "amdgpu_vcn: Can't load firmware \"%s\"=
\n",
--
2.17.1


--_000_BL1PR12MB514481ADF439A81349D03279F7609BL1PR12MB5144namp_
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
Can we just add a check for the new IP version in that case?&nbsp; This loo=
ks really hacky.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jane Jian &lt;Jane.Ji=
an@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 23, 2021 6:34 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Guchun &lt=
;Guchun.Chen@amd.com&gt;; Chen, JingWen &lt;JingWen.Chen2@amd.com&gt;<br>
<b>Cc:</b> Jian, Jane &lt;Jane.Jian@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case t=
o ip init for SIENNA_CICHLID</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[WHY]<br>
for sriov odd# vf will modify vcn0 engine ip revision(due to multimedia ban=
dwidth feature),<br>
which will be mismatched with original vcn0 revision<br>
<br>
[HOW]<br>
skip ip revision match case and continue use asic type to check<br>
<br>
Signed-off-by: Jane Jian &lt;Jane.Jian@amd.com&gt;<br>
Change-Id: I1ace32acbf3a13c0baac958508da1324ec387a58<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 ++++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 6 ++++++<br>
&nbsp;2 files changed, 10 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index 4e3669407518..0a91e53f520c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -1334,7 +1334,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_discovery_set_mm_ip_bloc=
ks(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_SI=
ENNA_CICHLID &amp;&amp; amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_device_ip_block_add(adev, &amp;vcn_v3_0_ip_block);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_discovery_set_mm_ip_blocks(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c<br>
index 4f7c70845785..87f56b61be53 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
@@ -86,6 +86,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;vcn.num_vcn_inst; i++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;adev-&gt;vcn.inst[i].dpg_enc_submissi=
on_cnt, 0);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_SI=
ENNA_CICHLID &amp;&amp; amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fw_name =3D FIRMWARE_SIENNA_CICHLID;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto next;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versio=
ns[UVD_HWIP][0]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 1):<=
br>
@@ -168,6 +172,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+next:<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D request_firmware(&am=
p;adev-&gt;vcn.fw, fw_name, adev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;amdgpu_vcn: Can't load fi=
rmware \&quot;%s\&quot;\n&quot;,<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514481ADF439A81349D03279F7609BL1PR12MB5144namp_--
