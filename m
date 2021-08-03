Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733B3C4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 12:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1127960F01
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 12:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1127960F01
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F3B89FE3;
	Tue,  3 Aug 2021 12:58:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC0189FE3
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 12:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYpZMt8v4AHZuJkrVJ1fG/n9oH3MdpBoBXKS9coza3ple4F/xRe3OLuFXO2vOfocRbJ6HseWhyMVWd4k4LDj+4vot+4mhtZIDTNqEibbwBgRj9TO/rTs+5SHPDwARCs7sRIca75xniU0C1calxOK55hOeiFScr2+0UbhI2CpFM0d8/rfX/yjksKJVkCznW9C6wAtTb9JGlcW3+K0Go7v8uZqiSgpbxTJ94swBp5awzJopCwQ08R8+UlpY3G1pv9SGY2t71nDQU7jVWico2jabHIFNqGXaa97ZkH6JcRUyFnOlwrJWNQixSMOj1K4ueMGboxbXMuXxfdYqlDgkF3Njw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kT0JJLK3LST5ugV1qEMTOedVM3+R2VEcqDrYVGq2l4=;
 b=HglvyocpF6AYp1Tsf/m6qap6qTTc87g/Rs5nD+zSBLw05TkO4FbcSxjMarjb+hM9q9bfQxWuky8vTbhmUioAUnowVU+G+Vvk5OCt1gMmDtsgCAyaTxnAj/IR3xxMEA7+GfesUTVHSvxyYWw0b1PcqsdaLxkoRXHb+v6fmaN2EiqlOwIAm3PeW0qjv5eB9+yIkSShi1H0F5JTDEcd3TlsA+KXBZ6C1m1emg4/NIivFsUoahTjthUxflTMwCtiPosOYnKZniNG771UVw45W7+AlHiNL9R/q9w3v3Zhwf2VWNFyNE0GLIMf68SoiYowFV9hcahm2i4IVZz6NKj/4qfPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kT0JJLK3LST5ugV1qEMTOedVM3+R2VEcqDrYVGq2l4=;
 b=XVOepJoUZtqIK/95MUpHUTlbTB9kzoqIijGtvjefMJGkADyySYmU4a1yxnsjuhHCFmKlfHIPjC3ol3aHbVVjiMhJMzDmmllIWyF8qvtSEgOuNM5+rWb8EkCFFdLyWR7y1boaWUJDdIUUsE3zvvpRzxRDf4+KNislPie3zG4V2kE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Tue, 3 Aug
 2021 12:58:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4394.015; Tue, 3 Aug 2021
 12:58:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "S, Shirish" <Shirish.S@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/display: fix DMUB firmware version info
Thread-Topic: [PATCH] drm/amdgpu/display: fix DMUB firmware version info
Thread-Index: AQHXiEOL1eW4RuDsFEC2Wzp5NhzXHKthvHkP
Date: Tue, 3 Aug 2021 12:58:14 +0000
Message-ID: <BL1PR12MB51447637328F3ECBD3C99292F7F09@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210803084228.57992-1-shirish.s@amd.com>
In-Reply-To: <20210803084228.57992-1-shirish.s@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-03T12:58:14.379Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdf4dd44-20f9-4e43-e2af-08d9567e5b92
x-ms-traffictypediagnostic: BL1PR12MB5207:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB52072F577AE9A017AF89C477F7F09@BL1PR12MB5207.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T7tJAHakrzaPrUuTEBlkoWJ5vNLRn9vEU3bZiZX0hLQENoS+TwhXCBQI9hCKyEviZZY4dI6wdEJTtKW25dlzWj7KxZQTImu0Q3S73XSqE/+mTy60XVKglrqeSQfGHwUBPP7rq74uF8Noyz/iLXhOxgUpys5Q0JrO9qZeUNKRWV7vobmPVEcPyqO5wmmiOkhYcCBQoqgOxACTyL9iH4YJzOvm/yA9QSeb7bskyqIlcNFxxNvRp+OOUd2KModuX3WgrM8fQk6dk2MCFUzIEiZCJnxgVVrULuFoJUsO+I4b5Ls50SIJMM6MB9vgVLLscJ7Z9D5+VDJFDcmh9p1f5/8vTXMHhzpqbrm7AgKgTa3e4XYJUf+CHcZ3eNzIe/XpjekNXg7SpEQTq5Os62bNT2TXKM4RCalh/Mtbx8NwdVPSdONLvPxbrun7EC+E3LnJdPTNkBave1daE0lzpH9AgAUx3y5SCCZTemfBri6yeQrQeU7mP17qjqBAjvztT4MQC1ejeeV4T/xWG0JP2JPZUPIQbYh0ATn7tpX0AXzSoL5nhGSok/bTzpeBhqu/T2bhViV6Rc2+2m+MwOlGnRkXKMzwf/RiWC5VxxuYv7jFPCY9onb9OsDDk5G5T6Y2KVe95sygqRSLMk0zoC4mF6vLdnalpb7k9EPQz1OhfWPwIMOuNVtjri/D56PsjrN32pz1OqS51nxcfJkJaWeEmYdlv0jPRg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(478600001)(316002)(186003)(64756008)(66556008)(66476007)(66446008)(66946007)(38100700002)(76116006)(8936002)(55016002)(122000001)(5660300002)(4326008)(9686003)(8676002)(71200400001)(52536014)(7696005)(86362001)(26005)(6636002)(53546011)(110136005)(2906002)(19627405001)(33656002)(6506007)(38070700005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wzLSai6fGcwAT2NLxdtLGwGGjkR59LkmeWPjJd6VJpqEmulRolWeWr3+RsFf?=
 =?us-ascii?Q?hVGJq0LBaIbQhG/wozxdaFRlG0kbWrLc1ln7iVHOdiCIDk/4bOPm/OHVoL+o?=
 =?us-ascii?Q?7Dzu4cPLsqivZTiwwHftjHOt5mIctZItVeZS0euTH2iHBxgTNciSnRqadwV5?=
 =?us-ascii?Q?gnjTd7/5uOTe2SIZqd8g7NNqa2mKch5UwvN+PLhiahzSj/9KQZjmkUF8gN7h?=
 =?us-ascii?Q?Gq5wyms+11/uKkTb7qFa0ehk52kMFmrPL1BjXcyESl45RmaZKg+mEQU2ulcJ?=
 =?us-ascii?Q?nxpEsWiDXcHIjy3imiWETFSPeUgmy1xRqNTGNVKQ9ItBUu0Zvd92yF3qFei9?=
 =?us-ascii?Q?D3eaf90n2axGP5JCRbTWmeIrWSPr+BNR3/U/VFNfdn0LP25GwuCYQm0CCuUx?=
 =?us-ascii?Q?2H/ULbAArl2cESz+2NHXvj/oOK1bZLQRJuYsNoL/MvCc1U6rcc71KbsqRQcU?=
 =?us-ascii?Q?jkOMOPGYQa+JvXj4E4pBg8cvUWegO4k9FYZwG+QPQwY7EJvPN2fSiiVuGET0?=
 =?us-ascii?Q?PeyJjBqKejG1L6SvuaHfwR746979cUYvwaLggq6VC/OAARGH2djciQdTcWz8?=
 =?us-ascii?Q?pVPLtfuOd5Wv53xgH2nGP30QdrsLD0aKBHd+iRyq/rWm3juY9SyjrT5mZGW8?=
 =?us-ascii?Q?WLkP2vRF8CDdF2VxRO0kRo58DjauULVMS/uj9nyjO4wVwb5Yn9gXzzR1SfMu?=
 =?us-ascii?Q?mhCd2+XzsfjTtAncdoyOT8PpIJo35V3FvQUpRQZipCLI/FfGnGyZHdif+FLo?=
 =?us-ascii?Q?HdzcTkchbmMK5rJ/bNHgJlSdVPSA+XWYRLLMISGjVJWf5qL/YSu5mz/J04Tu?=
 =?us-ascii?Q?RbhsfLzOCcr7kLGYYO0pny9zIRapkg9vtcfWWq+pmSEc/TU1b/rj5Pe7DZko?=
 =?us-ascii?Q?5MBZU+B06cc7bea+2rKHOR1f9sg52XCZfoavystqw84s4CNckhLgtwHhmRyV?=
 =?us-ascii?Q?AWFAEfa7HI8jZCji8L4eD1adsAcQX4c/8+Gi+DfXn5PN+ZSEZ3Q0hl9q/5rY?=
 =?us-ascii?Q?6vL6rtURgDoezqxqE5+79nkVFmsA0UQpMtmTjobK+3Yo8ZbhTkB5+fKvM/tE?=
 =?us-ascii?Q?fDYFewVkTZuXlx5ZlR6fTS9GrIfFV+m2luhQula+nZHABrBaT58rTUolPX1s?=
 =?us-ascii?Q?kySAE2ZWz7Qks6tczJ5x3t5Ln16lFR+Jgr+eBrCPPmz6rfDzKvBigbHJ7iQp?=
 =?us-ascii?Q?hlWI1kZNeS5rG8Eh39Wv19VlRYqiy89uTM73zRxTlKShXD2RCvAZYVhuQct2?=
 =?us-ascii?Q?3EQhpGxRpD/m1EhRu5+F/RY1cIFoRPHo0AoElHEoOo7amDYWgyQokCxtFbUV?=
 =?us-ascii?Q?ZUgiSrfDk+0IBvBGTIcS3o6S?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51447637328F3ECBD3C99292F7F09BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf4dd44-20f9-4e43-e2af-08d9567e5b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 12:58:14.9218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4eQpRS5vQLnTrNcuOJjZmDL6XMJYQow3/6F8Ck/N/ql8j2mlo4OWzhhI03wx8qngpb5zwKb7GWqOjfmH840Thg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
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

--_000_BL1PR12MB51447637328F3ECBD3C99292F7F09BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: S, Shirish <Shirish.S@amd.com>
Sent: Tuesday, August 3, 2021 4:42 AM
To: Wentland, Harry <Harry.Wentland@amd.com>; Kazlauskas, Nicholas <Nichola=
s.Kazlauskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; S, Shiri=
sh <Shirish.S@amd.com>
Subject: [PATCH] drm/amdgpu/display: fix DMUB firmware version info

DMUB firmware info is printed before it gets initialized.
Correct this order to ensure true value is conveyed.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7e09b6d26a51..396a2dca2fe0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1548,6 +1548,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev=
)
         }

         hdr =3D (const struct dmcub_firmware_header_v1_0 *)adev->dm.dmub_f=
w->data;
+       adev->dm.dmcub_fw_version =3D le32_to_cpu(hdr->header.ucode_version=
);

         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
                 adev->firmware.ucode[AMDGPU_UCODE_ID_DMCUB].ucode_id =3D
@@ -1561,7 +1562,6 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev=
)
                          adev->dm.dmcub_fw_version);
         }

-       adev->dm.dmcub_fw_version =3D le32_to_cpu(hdr->header.ucode_version=
);

         adev->dm.dmub_srv =3D kzalloc(sizeof(*adev->dm.dmub_srv), GFP_KERN=
EL);
         dmub_srv =3D adev->dm.dmub_srv;
--
2.17.1


--_000_BL1PR12MB51447637328F3ECBD3C99292F7F09BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> S, Shirish &lt;Shiris=
h.S@amd.com&gt;<br>
<b>Sent:</b> Tuesday, August 3, 2021 4:42 AM<br>
<b>To:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Kazlauskas, Nich=
olas &lt;Nicholas.Kazlauskas@amd.com&gt;; Deucher, Alexander &lt;Alexander.=
Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; S, Shirish &lt;Shirish.S@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/display: fix DMUB firmware version info<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">DMUB firmware info is printed before it gets initi=
alized.<br>
Correct this order to ensure true value is conveyed.<br>
<br>
Signed-off-by: Shirish S &lt;shirish.s@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 7e09b6d26a51..396a2dca2fe0 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -1548,6 +1548,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr =3D (const struct dmcu=
b_firmware_header_v1_0 *)adev-&gt;dm.dmub_fw-&gt;data;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;dm.dmcub_fw_version =3D le32=
_to_cpu(hdr-&gt;header.ucode_version);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load=
_type =3D=3D AMDGPU_FW_LOAD_PSP) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_DMCUB].ucode_=
id =3D<br>
@@ -1561,7 +1562,6 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 adev-&gt;dm.dmcub_fw_version);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;dm.dmcub_fw_version =3D le32=
_to_cpu(hdr-&gt;header.ucode_version);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;dm.dmub_srv =3D k=
zalloc(sizeof(*adev-&gt;dm.dmub_srv), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dmub_srv =3D adev-&gt;dm.d=
mub_srv;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51447637328F3ECBD3C99292F7F09BL1PR12MB5144namp_--
