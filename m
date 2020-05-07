Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9FFC38A24
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 18:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D56E20575
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 18:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lx3+QiA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D56E20575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0413F6EA57;
	Thu,  7 May 2020 18:55:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7032F6EA56
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 18:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDhmOfARpr5zla19NXhyGxnZ6wLaDPe7V+TpTNInsuK15l+apk2ryanitTqkzDSY03HOaYefxjq+lsoJJ+z9Ww2a4bF4lPsFi3/iPgLdyMqf7M68FG2qbxtDwbeKsbFqX31H0cKNkXXDXx65QIO6f1vQ3cJbZks3+B8+gEX2CML43ArbvfHOH6ZPwThAvMl5GuTUNrOL1lfVU9unUppMKuy9ax7sl5S03SuyF1yqu5CEh7vFPhGE04gL/Wbka7QP1NHoSE/q2U0dKST1Hx8iscUpt8qDB8vJGuXGO2EnKMlN890ZXFAGgKWEsnACkobILKJaeZW5ufRBAPNHgUAiDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHaKkpss4WHnC636c0PSAxxF5rCVpEPvJlUKUXcncSc=;
 b=Phozle6GeO1Z1m6TT6udxHeLh9G+OgEfI8mHtQNabPcUgIPwGqHfw2BRwfUb/2CxUPmG4zV03bA0OAv8tTVl+OQU5F+lLH0RmWe8uDLYUMJvSdjLU/dfuKGb3/z3q8gaH/iECvhU+mKM2Tp2+v1VeSv62lo/xyDUzqHDfqWCSpuRo3UqKv3Ci/fpogcxKhEufn+4v+eVkc88bDuFTygIIboH5mR1lNmX1jaST2Hlk6MSPlTHgT8bnWJWQu1aF/1nqKL3xkC5oWhX+kE5X04AZ8J4MGzoU2Cxfw6HpFk91cLOaS/ANYRB+0YkviuHYcA1qW6ggGHRgO4ZqiiRIKmR+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHaKkpss4WHnC636c0PSAxxF5rCVpEPvJlUKUXcncSc=;
 b=lx3+QiA36v5ukgkTpV13D919mW1JNcR3JFv70l1/vkpHfsL830DyaIGfGXMWkzJh46UwNFokWBUCnHQxJW16c7iXR3rrqZyMqE/fokb2Zaaf6qkNR6zQWLJl2WiGvbdxObFWEEHnUpd43VfNa9ZdUfTfixnVogbEaAwamIhli4s=
Received: from MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Thu, 7 May
 2020 18:55:43 +0000
Received: from MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::b167:4305:a89:ede6]) by MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::b167:4305:a89:ede6%3]) with mapi id 15.20.2958.030; Thu, 7 May 2020
 18:55:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] Revert "drm/amdgpu: Add ReadSerial defines for
 Arcturus"
Thread-Topic: [PATCH 2/2] Revert "drm/amdgpu: Add ReadSerial defines for
 Arcturus"
Thread-Index: AQHWJKDtKKL61d00qUulN50VPjV0pqic+Mzm
Date: Thu, 7 May 2020 18:55:42 +0000
Message-ID: <MW3PR12MB4491DAA50DB389E772496DCCF7A50@MW3PR12MB4491.namprd12.prod.outlook.com>
References: <20200507185403.5114-1-kent.russell@amd.com>,
 <20200507185403.5114-2-kent.russell@amd.com>
In-Reply-To: <20200507185403.5114-2-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-07T18:55:42.148Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.37.167]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f3847c2-340c-473c-d5eb-08d7f2b83e59
x-ms-traffictypediagnostic: MW3PR12MB4491:|MW3PR12MB4491:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB4491E008FA8A91F0AB0A2496F7A50@MW3PR12MB4491.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:299;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 64+O4A9qm4p7Zut848RgIdbWvOht9iFiQNF42ejG4J6bmPcicYWj6ZGAyYGOGv0vamdvsYkgplrTidM8oiBwV010XNhQCm5fek1n3bFRHSyugucy+pNjVzQ4P41qRaIY4OwLVWKuyA/0jZSQ0G4Y7jmHYksYINYCD+bt1odUBqavPxvTO7HyRCK01Jj6DeRLS6S/wJAVDBig28Osx0sqSzbZLkG/glqlOXlKEz4EHax7/Q68NiJiRWOLtAIrKKGlxwWSM7YGa03ROpaK/LDXvvmbeYfz+oyKNYkxeeElSugBokbC+28xFZsWA3SQ+tVxCiTPQVSDQeUPhWlseRKDvDUI5PEPGsfT+u2aPOrRJU+zE1+904utQbI0kmtCXrrIxRnffD9jY8t+4aqDBfSqscPW1MbzxlHiD6PNvi6ZDqnsmkzVjkMFZVvANR0ZRA2nB10V9CJg8ejpmojEHckT7v61vYEFf0DaEaiYz5Z/4NdrYN7zI4Ujuzc6a3apzOUf+omPlo1CO19rsJ6phrTkWlVocTleZw63J34CrmPq+2PulRZBAiqk9Otmm6JL5Trc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(33430700001)(71200400001)(45080400002)(9686003)(53546011)(966005)(7696005)(33656002)(83290400001)(52536014)(64756008)(66446008)(6506007)(478600001)(66556008)(83300400001)(2906002)(33440700001)(5660300002)(19627405001)(83320400001)(83280400001)(83310400001)(76116006)(316002)(55016002)(166002)(8676002)(110136005)(66476007)(86362001)(8936002)(66946007)(26005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: pC+ykhwE4Z0M1HO1xn+LzSezgVqv6SO+64v+AMk7C73SFpUtjbiK5k1+xsRBdBCItrETTv4OxzHdKzzHaBKVpkGiE0nCICMtrzPOiTAV3UIcgCun+w6BXVl/dD7tN/8H2AOmGQWTWPbp2gIxQmfXzrw57iLCO8fvnAGj8wr/tgUSs5B8HItSZ4K0TQXnUn/iRg81jqeBvPZ7je4E2biNFPpLRBFoz8Zgh9fikwIGZtZD+K5xETBzW+2mPB2YKqx7XwhuO6weHEz8Jy+Bu08Z8ts4ZAsZ7QpnWKL2Q2NQ4VkqzMIpAbT/EC4zd5KfOs3y6HDHoZkB+pG1h+6I+rHswb8BK5Hk4pnxd4gJ3auo+92QmZ9NkWSFauoag6EK56tkFsiGNL4AvSPGHba6JiLz/q2rCCpPlycYatjGod4ARGw1jTX/GdyjesF4GJ93TZ1lTDgoDeWPDuMCByFsW35RmNg+kfILTaAnJKxMGVtVishxguLyEu2FEc3WGzqAH3rs2KzZFFsJ6svj8NU75Xp4Dz2Phw2T5IQ7wLlFdKWn6D0MkFyjxLsjANtjPvyNd1EAw3bFyUc+SXMXqwZWfp0UfTQBlazRoP/AnCyXsxGYsozd36T1gTvHGcxFRRsBZDLl9Pkf8jVdVHlWW7KC+cOhWoZWuggsbn0yCCwOeNfUnA8+W28xuvnOzTanPMx8u0H9J/tT9IEjCowf8zRSnYxUb+dgaT83pyMWe+zYnPrJ9uNGbYce9sQfoF0z3nexdE9D7KKZ7NKQ44Q9O2eibdbvN6MDoLeuOgSOQ/DyHo7qatM=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3847c2-340c-473c-d5eb-08d7f2b83e59
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 18:55:42.9427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICB0nM+TnKAuxv/HVhb3Bqj5IO2+C3ysLzhvR20EBiYH1Jo4m157+Dt4YSUBDKT9N6pWh3H01zM2T8pSeWFsSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
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
Content-Type: multipart/mixed; boundary="===============0525553412=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0525553412==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4491DAA50DB389E772496DCCF7A50MW3PR12MB4491namp_"

--_000_MW3PR12MB4491DAA50DB389E772496DCCF7A50MW3PR12MB4491namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Thursday, May 7, 2020 2:54 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH 2/2] Revert "drm/amdgpu: Add ReadSerial defines for Arcturu=
s"

This reverts commit a0d4939d8616fab676699dab8ba3cbe519d4a8e9.

SMU does not support this on Arcturus right now

Signed-off-by: Kent Russell <kent.russell@amd.com>
Change-Id: I50efa3695570302231986d56c2351aac331726ca
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 2 --
 drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index e98d92ec1eac..1c66b7d7139c 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -128,8 +128,6 @@ static struct smu_11_0_cmn2aisc_mapping arcturus_messag=
e_map[SMU_MSG_MAX_COUNT]
         MSG_MAP(SetXgmiMode,                         PPSMC_MSG_SetXgmiMode=
),
         MSG_MAP(SetMemoryChannelEnable,              PPSMC_MSG_SetMemoryCh=
annelEnable),
         MSG_MAP(DFCstateControl,                     PPSMC_MSG_DFCstateCon=
trol),
-       MSG_MAP(ReadSerialNumTop32,                  PPSMC_MSG_ReadSerialNu=
mTop32),
-       MSG_MAP(ReadSerialNumBottom32,               PPSMC_MSG_ReadSerialNu=
mBottom32),
 };

 static struct smu_11_0_cmn2aisc_mapping arcturus_clk_map[SMU_CLK_COUNT] =
=3D {
diff --git a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h b/drivers/g=
pu/drm/amd/powerplay/inc/arcturus_ppsmc.h
index b426be7c76c6..f736d773f9d6 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
@@ -116,9 +116,6 @@
 #define PPSMC_MSG_DFCstateControl                0x3B
 #define PPSMC_Message_Count                      0x3C

-#define PPSMC_MSG_ReadSerialNumTop32            0x49
-#define PPSMC_MSG_ReadSerialNumBottom32                 0x4A
-
 typedef uint32_t PPSMC_Result;
 typedef uint32_t PPSMC_Msg;
 #pragma pack(pop)
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C67572abb9c0c4048437508d7f2b80cdc%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637244744643483015&amp;sdata=3DC%2B1WKdorha3NIZHKx=
eNQTcD8krgBeP2I2crG0dCrRPk%3D&amp;reserved=3D0

--_000_MW3PR12MB4491DAA50DB389E772496DCCF7A50MW3PR12MB4491namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kent Russell &lt;kent.russell=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, May 7, 2020 2:54 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] Revert &quot;drm/amdgpu: Add ReadSerial defines=
 for Arcturus&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This reverts commit a0d4939d8616fab676699dab8ba3cb=
e519d4a8e9.<br>
<br>
SMU does not support this on Arcturus right now<br>
<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
Change-Id: I50efa3695570302231986d56c2351aac331726ca<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 2 --<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h | 3 ---<br>
&nbsp;2 files changed, 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index e98d92ec1eac..1c66b7d7139c 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -128,8 &#43;128,6 @@ static struct smu_11_0_cmn2aisc_mapping arcturus_me=
ssage_map[SMU_MSG_MAX_COUNT]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetXgmiMode,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_S=
etXgmiMode),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetMemoryChannelEn=
able,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; PPSMC_MSG_SetMemoryChannelEnable),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DFCstateControl,&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_DFCstateControl),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(ReadSerialNumTop32,&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; PPSMC_MSG_ReadSerialNumTop32),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(ReadSerialNumBottom32,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; PPSMC_MSG_ReadSerialNumBottom32),<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static struct smu_11_0_cmn2aisc_mapping arcturus_clk_map[SMU_CLK_COUN=
T] =3D {<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h b/drivers/g=
pu/drm/amd/powerplay/inc/arcturus_ppsmc.h<br>
index b426be7c76c6..f736d773f9d6 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h<br>
@@ -116,9 &#43;116,6 @@<br>
&nbsp;#define PPSMC_MSG_DFCstateControl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3B<br>
&nbsp;#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x3C<br>
&nbsp;<br>
-#define PPSMC_MSG_ReadSerialNumTop32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x49<br>
-#define PPSMC_MSG_ReadSerialNumBottom32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4A<br>
-<br>
&nbsp;typedef uint32_t PPSMC_Result;<br>
&nbsp;typedef uint32_t PPSMC_Msg;<br>
&nbsp;#pragma pack(pop)<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C67572abb9c0c4048437508d7f2b80cdc%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637244744643483015&amp;amp;sdata=3D=
C%2B1WKdorha3NIZHKxeNQTcD8krgBeP2I2crG0dCrRPk%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C67572abb9c0c4048437508d7f2b80cdc%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637244744643483015&amp;amp;sdata=3DC%2B1WKdorha3NI=
ZHKxeNQTcD8krgBeP2I2crG0dCrRPk%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB4491DAA50DB389E772496DCCF7A50MW3PR12MB4491namp_--

--===============0525553412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0525553412==--
