Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7919C43461
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 09:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DFA66109F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 09:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFA66109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 092EC6EB1A;
	Tue, 18 May 2021 09:36:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 045F56EB18
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 09:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5rwcOJygDaSdxHuzRoTj2GHTBOGibXm8grkz+leJLmqo+wh19qd2iF4sxFQAnE+dYwGoFiP61NUQagxlQIWflLYT3fqtGD6tYaV8VQu+CElIq6vymFXGdJjylA8X/oTltCbtsIY4tFyTMjFTKKPaYFf+NB3WdMV40QVPTnSQlEbCQoCuPi6MMjYIry7OQ972xmpOqyK/vkYPIXuPNZ+MknBX6Gmfc7mDloPYg8ss9mzrg95Q18sft7PvDzSQqb0fsqCkX1oDy3cdQJGkOUejBisERc4RAwaO///BkIPgXD9N7Y6YdgAz3IJEnQn9+Asm1GyinPsBaxoTJj/ibQMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKByAscCC0WM1lxNV8ASF/bxxiIIHJjcr5K7Q9PWKzo=;
 b=VtQ404SuflrwWB4EYkyYsoNKIqrMvPDrLnl8BCLQzCgp88eGCj24PjfYaN46X/ydSdnBL2THL5CFZ5CLeac4mMY9fK6Gko6TMmVcDfg4wbmqLwKhDx6IBW8o2mNEGzAHPbx9ybbL0omlGz/FE7fQB+lCBm9dCCmvhknf8q4Pcqvr4xgJqdy8NLgGcVIW9wrpskx7rVnhuKp1SDt1cEzIRZ8x3px4ojLsGxrOwX6EyyUYNdZDeTMCmY2IfZE3TNI+ZE1xOjmcS9L1wi+JFMIhxDHDybmB8H0QuQ9MiZTp95nWcV0UmZFrDWfPa7ccyWhME+Jj20o1UR5oUjEcu33P0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKByAscCC0WM1lxNV8ASF/bxxiIIHJjcr5K7Q9PWKzo=;
 b=CYDsOZ1kJZ8dtOnOygu///mHIyytgy3H3LYV2Djb83RA43mzhyj9wBTX30GCLHMAcenWD7F1mu2WCKhF+la50Kl71GFxoAp98DvzFc/Mrgs2dkFRyNWffc4+PP90l71wO7zf41SvLAlkrYJcx7mpD/OZHotTUWRNdAVQKePzBNs=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 09:36:55 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b%6]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 09:36:55 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: modify system reference clock source for navi+
Thread-Topic: [PATCH] drm/amdgpu: modify system reference clock source for
 navi+
Thread-Index: AQHXS68oFX+kcEawPU2LnFqXVuU3lqro+sb7
Date: Tue, 18 May 2021 09:36:55 +0000
Message-ID: <CO6PR12MB5473443F7F5A09DC716E4478A22C9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20210518062603.1357891-1-aaron.liu@amd.com>
In-Reply-To: <20210518062603.1357891-1-aaron.liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-18T09:36:54.618Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b0e4b6a-bd0a-488e-71e3-08d919e079b1
x-ms-traffictypediagnostic: CO6PR12MB5395:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB539560FEC6E9D493B2FE6B55A22C9@CO6PR12MB5395.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KmPsYOJJRL4/dwRw7juOKYSxFfNEzolhLvbtFL5HNK6YH4Da1VshgXSDT3WgB7yXEFjvLoOHk+3dMHJW9vwXRdyvpeuoqA6tPqErNGLOwdwdMZlZF79N8O/sRc9Xz2Z9Zka+l4a3VhhFSOJeSGrlNt7zIe9JRm2I7Bc5Aly4nAw3clt4U9Z9RQPL9MkjEU+6sJjpczRdduaUFsqV1AJsM+W9v4WRPJfrBrQzwhcKT4sEOrM/3UokihUDVG7ByK09ZAkiGIFICOodFHQyWd1X7xmk0rnn8b3HT6HgfIvFkxCWgAgNyeLoGWgbCzZXmrcDzXbXOqYCtbNzTV+JQdvr9IZQS/v5eR/pAIuIE7JlRqGBlUe8KoWRix4pVbMg6sjcGCHemcBfE5C60LgEsDkfoF7KEmJKWTPY+5wXtjiJpiNtFN7JBIz3BeVdW8Rja0tcdkega5pHRYzJP30B6CQXVZQVJUfgRAPbkk2ZIjoRFGXenyxdbfCdfekly3FEIHLNk0Nv85CQpVrG0jkGtB+0V0KoM9fPLpujAzSz7cloW1Hfkpw4a2aJafLh51SvokSKkf83Yts6qJEVdqsykkm7+qnZ4dlEHDeNl8Q6YL0n9eOYhUSrUfSSvv/T5SOVG6MhGDHDjK+exx5rCm6MCci7jQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(7696005)(54906003)(71200400001)(45080400002)(26005)(966005)(66476007)(53546011)(6506007)(110136005)(66446008)(64756008)(66556008)(122000001)(5660300002)(186003)(33656002)(38100700002)(316002)(4326008)(52536014)(8936002)(9686003)(2906002)(19627405001)(83380400001)(76116006)(55016002)(478600001)(91956017)(166002)(86362001)(8676002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?UzF8DsbfIteV6TpZ4K9K1/Avja0BIZ4wJUBeBPMFXmA4Biscmbiyz6XUj5?=
 =?iso-8859-1?Q?r9UB4ajG2ai74ufSo0jFwlBVUWf7bp06EEuEs1HIYUXblbmZaZQRsWPtRu?=
 =?iso-8859-1?Q?rLYT5pLgckhhrqdyEu8iUnTDu+YI2QHSWIqsO7ifrIjc9JExTH4h7RyUmC?=
 =?iso-8859-1?Q?nntNtYLWM8BK1w/Tf8CBsjIVCUf+LxpEcZw2Gr5yXufNm3yDV5bVWcLPd1?=
 =?iso-8859-1?Q?pQ7Zbkoib2RbKHslJyJ79rn6/pM9N+bVl55LBuTXTxP02KaRk8WbxgbjpG?=
 =?iso-8859-1?Q?A0qToxzA2rcL0mbT5fYKnHbrj9v0ElQfFC2UUeEdP9/xOwJ+j4nwR8fcL/?=
 =?iso-8859-1?Q?dxKwMDGtosLJP6MRyYZYS/udxTtY9buIThsUoEVlZYpQowRniadLKtlKwg?=
 =?iso-8859-1?Q?ea56D7woSPGAkBUGejXPNukRmq4T4uW6xAIhiMD/sFlD5OS61c/DWJS7+r?=
 =?iso-8859-1?Q?Fb0+5dA9mETMQ2L7VbYQo18pq+UVAJtBc7iNSfB2D47TEuS2TrccZhknBN?=
 =?iso-8859-1?Q?X/COOfR+uQzzDkbS1smMD5EGtkpKVnqBjqZyf/JPxm9CMIS8UPB4vTftER?=
 =?iso-8859-1?Q?L0kyZSvoX4rLGeQ9IJvJl3v2XMXp3ulkuXnkwGFLGH1g1kxYVzE++39Zo0?=
 =?iso-8859-1?Q?024pq6buKErAGhbiRdMZrA4zsBAVMwjqXG9WQAB0FfNMBEM3k2lB3kgVlf?=
 =?iso-8859-1?Q?iFjwwTHCdkW98ihfMECQsXD4P1Om7w9InfAhAwcSxsp7N/ssRFfnToyVim?=
 =?iso-8859-1?Q?yy5w+Y7gpCqALApa4X/qXQXyEbAoEwmoaWOSyWTgOXtLn0jg5B5QC0vQeZ?=
 =?iso-8859-1?Q?Q3dpWAU13xDHtxbEajJb5eGVhJ9PMVnFmGPAwNWjNv2NX/AR/A9h4m8zhR?=
 =?iso-8859-1?Q?V68z0jD6Ao3MMfC3BNQRzjWiaDZ+w4Co5AkzLxCLf5EpIkBPOBeteIekwG?=
 =?iso-8859-1?Q?rxR0cNoBGJFgOseOOVjutqYICQ/D7ScAukuWcbxjgcTM95Gg4iKCdFP8Yk?=
 =?iso-8859-1?Q?NCkMlZW3s0zXIkD1rMiQTO6al9v2QO8s4OiC513pXTLhpgG3sEC8lPYbJ3?=
 =?iso-8859-1?Q?JmcrFvOR25lTN/THoBEcsPthMb1yAFxHua9BPBoiWc+Z2/4F9hFiq21oKS?=
 =?iso-8859-1?Q?fVaR8mCIj29JzgjABtXGA6CUUkufvmUfLITG6p6eY7vh4pgocpsyiZfzyz?=
 =?iso-8859-1?Q?lsEoFbLMAl1jEqetFb42CzWKLz3eUq0Xr4iEi+LGCX+LjJ6W1JLnmRrSvz?=
 =?iso-8859-1?Q?zlg8HKo0wPhyupjq6vvwHbTDnO604yztGb/7uq/jBSiTXeAcvjJbeaDzxa?=
 =?iso-8859-1?Q?t0PtKj6lZcQivkoID1wnwBy7xTbocxloYrPE2ZUt3K4J2ypmyjbrLakwqW?=
 =?iso-8859-1?Q?VPs+u2kiHb?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0e4b6a-bd0a-488e-71e3-08d919e079b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 09:36:55.2944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+Q46GTtrgfQfe7I1UmZBOCe7aVDEDal722Nr40jPL6/Ix1CfnPK1csHd6lZuGXr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Content-Type: multipart/mixed; boundary="===============0578476590=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0578476590==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CO6PR12MB5473443F7F5A09DC716E4478A22C9CO6PR12MB5473namp_"

--_000_CO6PR12MB5473443F7F5A09DC716E4478A22C9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]



________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Aaron Li=
u <aaron.liu@amd.com>
Sent: Tuesday, May 18, 2021 2:26 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Liu, Aaron <Aaron.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: modify system reference clock source for navi+

Starting from Navi+, the rlc reference clock is used for system clock
from vbios gfx_info table. It is incorrect to use core_refclk_10khz of
vbios smu_info table as system clock.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 8c417014ca89..83ca58426139 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -546,6 +546,21 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_d=
evice *adev)
                 ret =3D 0;
         }

+       /* if asic is Navi+, the rlc reference clock is used for system clo=
ck
+        * from vbios gfx_info table */
+       if (adev->asic_type >=3D CHIP_NAVI10) {
+               index =3D get_index_into_master_table(atom_master_list_of_d=
ata_tables_v2_1,
+                                                  gfx_info);
+               if (amdgpu_atom_parse_data_header(mode_info->atom_context, =
index, NULL,
+                                         &frev, &crev, &data_offset)) {
+                       struct atom_gfx_info_v2_2 *gfx_info =3D (struct ato=
m_gfx_info_v2_2*)
+                               (mode_info->atom_context->bios + data_offse=
t);
+                       if ((frev >=3D 2) && (crev >=3D 2))
[kevin]:
There is a hidden danger here. We can't assume that the higher version (fre=
v) is compatible with old one.
the code should change to if (frev =3D=3D 2) && (crev >=3D 2)) {} ...

+                               spll->reference_freq =3D le32_to_cpu(gfx_in=
fo->rlc_gpu_timer_refclk);
+                       ret =3D 0;
+               }
+       }
+
         return ret;
 }

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7C28bc3524cc2b430f8ee108d919c6494d%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637569161701557512%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DkD=
9yMGIWNpeCZc87I%2B4UufLoAssTGQc73DRjOx4ipXM%3D&amp;reserved=3D0

--_000_CO6PR12MB5473443F7F5A09DC716E4478A22C9CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Aaron Liu &lt;aaron.liu@amd.c=
om&gt;<br>
<b>Sent:</b> Tuesday, May 18, 2021 2:26 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Liu, Aaron &lt;Aaron.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: modify system reference clock source fo=
r navi+</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Starting from Navi+, the rlc reference clock is us=
ed for system clock<br>
from vbios gfx_info table. It is incorrect to use core_refclk_10khz of<br>
vbios smu_info table as system clock.<br>
<br>
Signed-off-by: Aaron Liu &lt;aaron.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 15 +++++++++++++++=
<br>
&nbsp;1 file changed, 15 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
index 8c417014ca89..83ca58426139 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
@@ -546,6 +546,21 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if asic is Navi+, the rlc referenc=
e clock is used for system clock<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * from vbios gfx_info table */<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_N=
AVI10) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; index =3D get_index_into_master_table(atom_master_list_of_data_t=
ables_v2_1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_=
info);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_atom_parse_data_header(mode_info-&gt;atom_context, in=
dex, NULL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &amp;frev, &amp;crev, &amp;data_offset)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_gfx_=
info_v2_2 *gfx_info =3D (struct atom_gfx_info_v2_2*)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (mode_info-&gt;atom_context-&gt;bios + data=
_offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((frev &gt;=
=3D 2) &amp;&amp; (crev &gt;=3D 2))</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">There is a hidden danger here. We can't assume tha=
t the higher version (frev) is compatible with old one.</div>
<div class=3D"PlainText">the code should change to if (frev =3D=3D 2) &amp;=
&amp; (crev &gt;=3D 2)) {} ...</div>
<div class=3D"PlainText"><br>
<span></span>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spll-&gt;reference_freq =3D le=
32_to_cpu(gfx_info-&gt;rlc_gpu_timer_refclk);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7C28bc3524cc2b430f8ee108d919c6494d%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637569161701557512%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DkD9yMGIWNpeCZc87I%2B4UufLoAssTGQc73DRjOx4ipXM%3D&amp;amp;r=
eserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D0=
4%7C01%7CKevin1.Wang%40amd.com%7C28bc3524cc2b430f8ee108d919c6494d%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637569161701557512%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;amp;sdata=3DkD9yMGIWNpeCZc87I%2B4UufLoAssTGQc73DRjOx4ipXM%3D&amp;amp=
;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473443F7F5A09DC716E4478A22C9CO6PR12MB5473namp_--

--===============0578476590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0578476590==--
