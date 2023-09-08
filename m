Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDA5EEB566
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 19:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6061210E1DB;
	Fri,  8 Sep 2023 19:51:57 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B41AD10E1DB
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 19:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAqqvmR4yLBZ1Wepshakd/A2bVeNkg3IS81d27ghET79bib9EazGv6yny9RUdrVuUCRjILrITycb3hK7FXDUo6jC2NcfDGNY8R6NIzXrxINTufO6QWk9o1yj9hDmTiMPP3QlvS5BRThI9cAJp4yAezT0lTxXYOFBxtwucFT5rE43K7Xu2RGjXUKl87NUaSH+vkLsiP09dyidjS5rt1Xf1sb3+TU23v3ruyNeOC60FRMNQ2FWvFVUFqW+hLiwj2nL10IDGEHxU+v7VlckOgkL18ySkNBDsHK95iYSLw5fCh8ipa6vLrxw72C9lJFla8q9k2J+w5jwyr0GtWnyYNZbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ5s4hmGnCdLtCwdAoypaHKvsXog09PdibT364uXl08=;
 b=fopJc4byortKaFQdDSP2NNJZY7kPx0B2Ea7mQMZdpp50BLqVxui16wnH1YqcT9w/LSdQ9XfbTa2DoJQg6C7l93h6IgZDDh31DtwXUXz7DLSra8RcGRvcyuBiDeCjQ3iW77dzoR+xa8iOkoLGv8CrLHpNP3RdGmAsR5cAZUF72iPxeURJ+uRePejt5j6NVzbdUjIc9AscJqpWarOlryKOPyrMPXuT8KzK5DEpeKLRRvBhyqyWElF0/Hn+9GK5JWfOg5mlzCI7N6LfXuqQYrpUHPoCueJkUfbyF/YNjHmzP2ZFEzyyIC8TVXda8+SBaei74bvA9kyy5dzOL8HkfxN9Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ5s4hmGnCdLtCwdAoypaHKvsXog09PdibT364uXl08=;
 b=ISYCUT9UAVukbPRoamV73pu7R4a5s7qDkFc5zwFWMoudaMhgkXINRUgql51AwI5rR6i/svScTxCJ7VfnKqGYhnr9zhAIhnTBMyzBlsABZ35RspX3yWKPNfNNt2EY6rCJ+E0zCY4m4IE5ixvsz93Ek8lpMZ5I6hhsTyXuv+965Xg=
Received: from IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:20e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 19:51:45 +0000
Received: from IA0PR12MB8713.namprd12.prod.outlook.com
 ([fe80::2ea7:3e66:b686:bdbc]) by IA0PR12MB8713.namprd12.prod.outlook.com
 ([fe80::2ea7:3e66:b686:bdbc%3]) with mapi id 15.20.6745.030; Fri, 8 Sep 2023
 19:51:44 +0000
From: "Tsai, Timmy" <Timmy.Tsai@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/soc21: don't remap HDP registers for SR-IOV
Thread-Topic: [PATCH] drm/amdgpu/soc21: don't remap HDP registers for SR-IOV
Thread-Index: AQHZ4NfzgObSuWizmUGxMJdXrDidOrARWUNHgAAAVXY=
Date: Fri, 8 Sep 2023 19:51:44 +0000
Message-ID: <IA0PR12MB8713C5D7D6C59C75D5A8FF2A98EDA@IA0PR12MB8713.namprd12.prod.outlook.com>
References: <20230906153623.507284-1-alexander.deucher@amd.com>
 <DS0PR12MB8813BE64575EA3D952425B6AF4EDA@DS0PR12MB8813.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB8813BE64575EA3D952425B6AF4EDA@DS0PR12MB8813.namprd12.prod.outlook.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-08T19:51:43.604Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8713:EE_|MW4PR12MB6900:EE_
x-ms-office365-filtering-correlation-id: 20ff4f5f-bcf3-4f7c-762c-08dbb0a50751
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XMUQ+10Mv+Nlgqh5rljp55GnN5KV1NDjg0RT52uzP8KJO2Bc7Ckld0kcbngqlPQb4RJ/x4Y3sxHBpR6Z56EAu8PC7lX8p0nOhnmFTVn8OilvUiaJfu06+R6YgPTs0WD+zLhvzs2xdxfhNj7oAahRPBLZJXqtO6cQW6JyHmAQQx6a1AWnuU/vldMwhK67rPM5u5zuN5mH8rqRhTxKS+BL+pZpjl5X7vsvgjoPeBFvmHeKibLp485cCwaieXq+A6DcwLpwOCkxed4Z7WHnrCJ+ixZSqr8BrVcWG6lkvFy/837ISLKhyjJCPv7ZnskS8Jx9dUXlM3iJwS49exuixtrY/q49XB2IjqqKCfVsFeJi5XPIt98eXc+x4mAH8fqdJWe8xIdtN4QMDF6ZeFqTbCT7OFP2sTyxZUCR7YpBrTILIehSaXkLKjWqfSTAEM9AtRKhuJ865m+NCwqDcoAqAP2kYpBApoK2sn8TC2fm5BaRnVSxL1A1dzdQgnmsZ1CUfOPUFl9Vrqs7DHf2emkVF7NqzkjxXLoDB/gRlz+cIb1fh27oNgQu61ye4xoS+Mp9JpmFm61zrDWyMTdPeXx6pq7f0m73jTugvFYfVQXcDutFADwSr1URc21ti5CrsmP4SACN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8713.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(1800799009)(451199024)(186009)(38100700002)(55016003)(38070700005)(83380400001)(122000001)(2906002)(6916009)(91956017)(71200400001)(76116006)(66446008)(19627405001)(66476007)(66556008)(64756008)(66946007)(53546011)(316002)(6506007)(7696005)(9686003)(33656002)(86362001)(478600001)(26005)(52536014)(8676002)(4326008)(8936002)(41300700001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ARjkIZmolf9V7XZL0chakBgak1B1lVMYecVsvCxOXMW/FzpGylHzIRcz+Y?=
 =?iso-8859-1?Q?hnZRYgOIbOlW9FBQDnBPzeLpu4NLz/m5ugfjyAOcY2RKxo5+Sio2c2TGox?=
 =?iso-8859-1?Q?Fmeoe1asHMV0E6szASY6gORFpIafkrbQV6VgsxUfVPn9EqbD3fVQ3HKD9D?=
 =?iso-8859-1?Q?q4599HmDTff80XInqpS4af0d3pSiPi/Cx6Zs6RvNi7vLFKPhw57RKfIjkT?=
 =?iso-8859-1?Q?OAJ6NYVE6/V+8N4mWGj+8dqYXYFaT9pSRp8yDsgTy+D29KBCrG2XK8NBPN?=
 =?iso-8859-1?Q?JEto5xMYeJfsBCrZwbE/C2uubo88JWWBTsERYx7ZvMDsrXL0zDZ6lrFTJ8?=
 =?iso-8859-1?Q?CZe4NZd1FY1lQwJCAqQdMeDg31mgK2ATZ1/9umC50GOZSUe2RTRelRukoS?=
 =?iso-8859-1?Q?P10Y0btLVPB4/Jwa+n2FKujWkWxZ9f7tKCiP4iLq7WFX9TBB/WvBDegvZ3?=
 =?iso-8859-1?Q?3QB+v2YizcYNJawIUcbWPQrKx7OyFQ4jd4oBhy1ZmNUQJnbzX/6lAvX8Xu?=
 =?iso-8859-1?Q?7plXDF2Rx3JTjctHLMax7eov+AsxJad5Nkg3tbKZRV82WtHNMnJSpTglzh?=
 =?iso-8859-1?Q?JiHiphPhNVMXauYn/sjfjYyMSAQdE1BejbLb2TPOIml7O1vxWp2RLUPSMp?=
 =?iso-8859-1?Q?ADWSTqRTWT4v9HtoWRmdJUfpBZLNa38cbt5YjXkyILN/vOisFcyeRrbtoW?=
 =?iso-8859-1?Q?+JEyPb6Z+y8jSiMlThLzamD7eRJ5iUYa6LMSKfNC0igkVSrjm5LA9mQqUJ?=
 =?iso-8859-1?Q?9hDLlL6PQv9xFcU9LMBcryViM9L+K44I0ODrs0fkPa3pOhquY6rzJvadgI?=
 =?iso-8859-1?Q?j/FE7plGpaALPtu5E3SWGuu5iKWN6mOBRbIWcvLMudAq8s92XzjOrDFyz4?=
 =?iso-8859-1?Q?QtYa/xNjAWr/iFUnUHj5TIARCMorbhuw1O0rlAEo/WKNhBA372LdiMOdq5?=
 =?iso-8859-1?Q?6aI5HTO8ucXvvcWljK6jEySObNQOUy4hHIC6qqxC0oc7fW9Z/+N1KIYfW0?=
 =?iso-8859-1?Q?3KzjdViL486omvwale9FJJ9eyVoAmJN4llFbZGBgcZ/w1pX2v46rjFd/+L?=
 =?iso-8859-1?Q?C8X3pBs+qFGizJwz8ZUgQGaJepun0WMQrSoU4Tr3dvDLU6tw5ijvbW2be5?=
 =?iso-8859-1?Q?j/THJ152jQhQKcFjl/1H6EUxDwOXb88nmQqyeTXGvf32MNBpEr0wOhSzHG?=
 =?iso-8859-1?Q?sO3JxoiIfGnbFOkneg4rdPbfwk3xwDCYxsjrL6VOoc1X1Zl0eQSBjv5oMN?=
 =?iso-8859-1?Q?WOkAfwpKYHo+cqk0ffs99YgXGJzUEh78B6FZlkUGrb8d4izFRoRK/PEhHn?=
 =?iso-8859-1?Q?dZO4DMSRYwkBGljgvEvV/HeeyEbUwLJHRidZFgtLJhBgjbXBxl6Pj9c713?=
 =?iso-8859-1?Q?ouYf2FyFWvIyjoHSSYRALBMRqATzeKb1yWACC82C/heQ8o1Z3VNDLifBAa?=
 =?iso-8859-1?Q?QGYXLxAkQ9VBcIBuMmV5AqAZfRtLOAQ7Bg8EgQRCH4LKQqj4WphhJSjrx3?=
 =?iso-8859-1?Q?hn3XUfBt07LNuRjeRgA4Y4ywjZvr4/WDDyn02dmCSndEnsKdKlfz8c0+SW?=
 =?iso-8859-1?Q?1codNd520mawHprR38ZxxRE7ML5+JeSyOMQUf09Q8PdOhaCOo3IbNUAwMH?=
 =?iso-8859-1?Q?i9iMvBTdmYCOo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA0PR12MB8713C5D7D6C59C75D5A8FF2A98EDAIA0PR12MB8713namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ff4f5f-bcf3-4f7c-762c-08dbb0a50751
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 19:51:44.1505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTaZJoNt3J2CJ2Vt0xKv2Nm3ColWCa4xKhLFe2nxjQB6OknkjuzCinG822W4lDlIyY009uVe9SUXd1q2oqaU/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_IA0PR12MB8713C5D7D6C59C75D5A8FF2A98EDAIA0PR12MB8713namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Timmy Tsai <timmtsai@amd.com>


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Wednesday, September 6, 2023 11:36 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/soc21: don't remap HDP registers for SR-IOV

This matches the behavior for soc15 and nv.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index ef297b41623b..2ecc8c9a078b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -778,7 +778,7 @@ static int soc21_common_hw_init(void *handle)
          * for the purpose of expose those registers
          * to process space
          */
-       if (adev->nbio.funcs->remap_hdp_registers)
+       if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev)=
)
                 adev->nbio.funcs->remap_hdp_registers(adev);
         /* enable the doorbell aperture */
         adev->nbio.funcs->enable_doorbell_aperture(adev, true);
--
2.41.0


--_000_IA0PR12MB8713C5D7D6C59C75D5A8FF2A98EDAIA0PR12MB8713namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div align=3D"Left" style=3D"font-family: Arial; font-size: 10pt; margin: 6=
.66667px 5pt; font-style: normal; font-weight: normal; text-decoration: non=
e; color: rgb(0, 0, 255);" class=3D"elementToProof">
<span style=3D"font-family: &quot;Segoe UI Web (West European)&quot;, &quot=
;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica=
 Neue&quot;, sans-serif; font-size: 14.6667px; text-align: start; display: =
inline !important; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255=
);">Reviewed-by:
 Timmy Tsai &lt;timmtsai@amd.com&gt;</span><br>
</div>
<br>
<div>
<div class=3D"x_elementToProof" style=3D"font-family: Calibri, Arial, Helve=
tica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
style=3D"font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b> amd-gfx &lt;am=
d-gfx-bounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexa=
nder.deucher@amd.com&gt;<br>
<b>Sent:</b> Wednesday, September 6, 2023 11:36 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/soc21: don't remap HDP registers for SR-=
IOV</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">This matches the behavior for soc15 and nv.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc21.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c<br>
index ef297b41623b..2ecc8c9a078b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
@@ -778,7 +778,7 @@ static int soc21_common_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for the purpose of=
 expose those registers<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to process space<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.funcs-&gt;remap_hdp=
_registers)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.funcs-&gt;remap_hdp=
_registers &amp;&amp; !amdgpu_sriov_vf(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;remap_hdp_registers(adev);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable the doorbell ape=
rture */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;en=
able_doorbell_aperture(adev, true);<br>
-- <br>
2.41.0<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_IA0PR12MB8713C5D7D6C59C75D5A8FF2A98EDAIA0PR12MB8713namp_--
