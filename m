Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C75C27C52
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 06:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBC3A10E6B2;
	Wed,  5 Jun 2024 06:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fgiXP3ek";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C14D10E6B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 06:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyvUVbDl+qkQgWP9UpJFa4BYBcvakv0hUfUzR9H1Ip1FI9IytDCLmhJQw1NjQ2OhQfQjtiWvvOJNDbQwD3NKCbPM72V77kJWE+vPZa8J4sIWp6sstdCGm24Ea4br4bSzFU4IEbdziGP+KBL92k1ifhTkr3aH2883Mota3PMHLCR/N3w31nyumzn/UWOwiWOnBT00kSlp6FmSr6gv4fRyqLg5R9LoMIXkefDeBiN62x5+jR4hrpIWoJ/z/39AsEd6FuRnd44ve2070aSpK6Vv47U9dQejPCEn/b35u8srIhtzyzqAw4aDexaAFRZzvVB/3wt9c1+uSyMuAMrNUuhZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqRwb85sUc99tIpl6cPuXMfjItn5L/vxf4M5q01DldY=;
 b=TNCwJV7y7+HMGkY2oK4FaDVQyFeExArRVOlb4c2ij5Q4raFw8VCWfeorknwxnHEW2AvlNf0V+DdjkAZoX+29Ey5KH1n4tTLH6nUU74QkITic15R04g4Ka7cM00oXchMOrTvfLNcxUCN9HIWBQAkw+zTaHSOz4yRGDgwu33Wu443yNU6hD2cO1bKGZC/wmwwQ9OC9XfD51GkPzEVcOfhLTiG3waoEiEaIFEcxBXrc9UA6+GZbH7QOb88f8JLbbulJAs5aDCHiCrZ+X6jZL9f0QTDgvGM0SQt8I9fzJWv5doaixPpJdogdC1U4ie4Yw0ECaG2qhWyiN3G5VxquDZXEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqRwb85sUc99tIpl6cPuXMfjItn5L/vxf4M5q01DldY=;
 b=fgiXP3ekTK7IA+bkRwHRz+NLi6QWuDT0SAz7cHx3N1prjtwmySyEZExHnUtC9IbC/83VYK+60c90Lvn5d+wtF5jmiIsnrgjwpL6st2tBtoCLUDWlGKgl9n9NI2bZM8CL7OZEHSXHgNsg8QsCXWXfQdqsE/ko+gyfTmWyQBBQJSE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 06:54:37 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 06:54:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 3/5] drm/amdgpu: create amdgpu_ras_in_recovery to simplify
 code
Thread-Topic: [PATCH 3/5] drm/amdgpu: create amdgpu_ras_in_recovery to
 simplify code
Thread-Index: AQHas0g7XAUcr9cIMUCkBc4y7MAtZ7G4w8xw
Date: Wed, 5 Jun 2024 06:54:37 +0000
Message-ID: <BN9PR12MB5257D4476A28C72626CAD5A8FCF92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240531104911.14748-1-tao.zhou1@amd.com>
 <20240531104911.14748-3-tao.zhou1@amd.com>
In-Reply-To: <20240531104911.14748-3-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=37b823e2-54fa-4b60-871e-68119b38eaa1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-05T06:54:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB7265:EE_
x-ms-office365-filtering-correlation-id: 749a88cc-a27d-4795-61f9-08dc852c5d9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?U3/P1vOLERvjqSn6Ek9/WvPjrWAwqc+FIYnljMq7CeZperdv8OOI+6IstY9K?=
 =?us-ascii?Q?ol9ycmU+q8ZyJgSg80cnk9o1V3vvdHM133Uw0oB+9g2MUSrG7Bzf6It3CRWF?=
 =?us-ascii?Q?c9L9kUxypCWme7J17x5zFO6JUGg3foZCPDIPlmhJwh56HNc0jOIlFFQtpd8B?=
 =?us-ascii?Q?XvXUt1vOpGpacIRIFuuoi8Sdkb6NpOKE67x3Q+Dl1JvhaE2nHO/6tSaBG6by?=
 =?us-ascii?Q?1FKzvXcXLjEj7oXTixiYr+dGwSUEzQTsQGoN8j2GZlJZHu7MQphtRSWsIBJK?=
 =?us-ascii?Q?oOdpsn3loE6qeaHsU4VTLCUqhAR9Rtnioj4g97LAx5cE/8aZatF6/K/XMVbE?=
 =?us-ascii?Q?dg6KV0osD4OY1i0yqcMYI4kkq43G7MG5AYjkE9kwL+OqLva6WLbzNgcw6dYA?=
 =?us-ascii?Q?nzK0dcWkHSGXsP6YgLD3Fs8iMWIebYHqxPIU2Qmw1HCYwCSFS9lcayHojy5z?=
 =?us-ascii?Q?ggWfWrVSVMs6Y1hXG0ZrQ+EEIMTk5hiv3SeRGS/WV5qz0F7H4+pQq9FZUBh7?=
 =?us-ascii?Q?O+wvgqbJOqvqlfRXQsF80d6Mk7f8eP+4G3h93RmtVgtt6j9Wn2dDsozn00NO?=
 =?us-ascii?Q?e/Suuid/vF04uIW52/kAhyEK6PuJiqZEitzJwJGJJv60rrBixQJBz6pO3dHO?=
 =?us-ascii?Q?k8fPu3ktNTEYrgozSUOiis4Ux4W+ZHXW1ChLDt7+tLnYUXzFMgK1g+m8hKEh?=
 =?us-ascii?Q?0ZrApgL7yGahZ8BCQ3O7VmJfXJkO0KLdBO/0FS7PtwcDJ/8kWCVuLtetJn4l?=
 =?us-ascii?Q?NAOYOYunsrrySN22mp+Z+WWynbcwyWcBn7oSJchVW5lpBwqw+U5u8TK0ukrs?=
 =?us-ascii?Q?4z9HjHXT2cjisH8FPFVAsKdAc/39/5ZeA6DPD85nnBV1Zd7A5K4h5I9QMOwT?=
 =?us-ascii?Q?ycgyYC2aSi/vqjQrsP2KH+TVlPMVnN//HkNPwhVWiuF8LbcXXnB2FQDx3CQo?=
 =?us-ascii?Q?FMfIuzkX+nP9wN+jNRyh6FQgcNaN/oLk/xZ0eA6SidVTCePODWt/rou8lZFM?=
 =?us-ascii?Q?lW4Ntrh/6EI9X/UJCkqrmpmhLomiMJnpxgqpKMYX5kw11n833QvYhisaHHpA?=
 =?us-ascii?Q?txAccTgpEa8b5OPG//VsIVukGvAsynH0rki5bPeD2s1Mw71sX0kKYk7g8Spd?=
 =?us-ascii?Q?jSSOva4KKOPZPDy/AnhwgT/lRWFUq33GmnKi8ii4YEuN+TOpGeFLkhxs3Xkc?=
 =?us-ascii?Q?6aeizRBQq2u+AcrqVcjxMKVB+dN6g7zDOirbYR1/8VSnDu6fKhb5ffDesUe0?=
 =?us-ascii?Q?b2Bm4uHvLGCXJ6v+FKGbFl/VoCXxLtjkxOFkMGl6ryzfEWouGWkGp1ZlK3WU?=
 =?us-ascii?Q?2HT+12vPGJukVSMlpMXx8mqR8wejG5USyYt+PLykuJMlag+u0IYcNDx5mFIX?=
 =?us-ascii?Q?cDjORS8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zZoQkeDc9tdZOajXoaMpLZMKPRprrTfOCdXThrMpy1xKx3dOyrX6br9ErvZc?=
 =?us-ascii?Q?wrCFXRauPGQdo3TPxe4fQeoyIHkhPa1KatyM2GrU4BDhQBn1iW78s/XaYXC+?=
 =?us-ascii?Q?IoVJltOpLKl7BVG+fBXc2iPHSwf8QrzcYNoi4Ws92jcSuZ+rDMK7Y+eD9nkI?=
 =?us-ascii?Q?KrJ2bz871FRE8GzwBDraWLLulMAz9oTbm5WmGm/H00KpZDGZDUFqgPy6zA0C?=
 =?us-ascii?Q?4Wn2lphXPmfFu2roP1bxbyNWLmtvB2k/U6ix5yXMsHPS1lymPkFiqBasTqs5?=
 =?us-ascii?Q?s1bB5OBT+kuS7c+2q4gIVPvoIkESLMOPJxNL8pLIB1nYaO8ay6g0Pa8MQ6z7?=
 =?us-ascii?Q?c1mecraHoxQ1Waw/VGf6sh+Lw/x9Sv+t7ehtXl2YOYOth4fm9ZSzbJ8nU4/w?=
 =?us-ascii?Q?XGAvvc4Va66MZ9hGPyP3g2KPSe2CyecXbFVtHLp0Ny5dsUhYFjuMzKPUhOfb?=
 =?us-ascii?Q?aquYtNZEqWDG0LSMFCwXDA/NtqcRWB3PROGhyZemR6ip9/Lvp/6qH+nbjRHe?=
 =?us-ascii?Q?b22aoAkcVeJNcEBpnPzBBeHqSSu8bX1wWqg3jUzr8VxJYD2hKV1FdjosL4ub?=
 =?us-ascii?Q?f03gj1i/GgR5n2mng99Vqf9aejiYhu9+Y9DHVtOmvgG/zvoaZ8XXQfuYAO4M?=
 =?us-ascii?Q?DcdLB5fR117QFVp4fotnybaI3CK7Vs8HthV5dOUbedzG5jAFocHlMP7xjaCo?=
 =?us-ascii?Q?7hn6LqKRKk5aeZPicNflukQjqUnRXfAukWnegJXpZkiakLb27SmHGA3IXMb4?=
 =?us-ascii?Q?12WTwp7/JG+ndh1Oep1FAWbglAQSrqUezJpn9oANrVVh8UMJIY3f94nCyNYN?=
 =?us-ascii?Q?6ae/k6O4D3vFxNy11mTICo1uLcOpupmMr2/sMoHksSJHdgF0dRANR4Rr7uWT?=
 =?us-ascii?Q?LNAymB5J+b7Znr3+Qbx9jubb8s3vLa638No0zsTzdiQl9aPV0JZZiXfZCcbr?=
 =?us-ascii?Q?4KWkcWr+70SLN4NSxZ2m4II6DXwWqGU0zOhewJkE5Tx9Ni5FTa3eTeEL2bZc?=
 =?us-ascii?Q?CaiT0YJE9DrUwqKAqEDdO8/bPXuWDr6FGMQG8qtEtkfRvlVqtldToo0iLIIr?=
 =?us-ascii?Q?IyTULDSVXeq7iJdYp8MFcMlnX52OordSFeLywsEwFNrGmYo+prxn5mewCBvR?=
 =?us-ascii?Q?TXBjJHZu7w5StB6rcFiB1gbRZ4QEobbBLf55RYrgj2xL1BI58ZyJEw4OYzLf?=
 =?us-ascii?Q?+X0Fh9YhNuWHypKU+85Kem+U7a8fVIqSCkvucFeUq1LTkqecx6CKzX9F1b7H?=
 =?us-ascii?Q?SMwcrk+k7SqbA/beMn7vCa2pmP08dBImwS9BnRsqgjj/wHIgkkeqfJSSZDjR?=
 =?us-ascii?Q?ttuDdc5Sbe3o2n3BfDlRy1Ia6Km3VDTxHHjz9qQ/QSQhyGuN/DU/X3Bnr2El?=
 =?us-ascii?Q?+hhIm3EK3/Jr+Z1/GAd0eWDcYiiJ1+1umLCZUWIo3QWF/5mwOKNYQ+1vcSX5?=
 =?us-ascii?Q?1GlCTNJPyXawejOH+mnpUB5b3oEDrYzCG0OwDkdr59klFsWaXspNmoWz7prG?=
 =?us-ascii?Q?AIFWn9xr2qvkHzPwkuWeC3U0LLqV+JJN85ndi4uYeSwv31FYnG+K4COnR1Oc?=
 =?us-ascii?Q?yOHml9UuMPMdhKjrb5uAXJWno4hUcacVHVFz5A8r?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749a88cc-a27d-4795-61f9-08dc852c5d9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 06:54:37.5017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRggulj9mww4OU7E6A89nQpFTETphXeVVXd4kQ4yScqvBWzqcZxC5vh4sydaU+JwC2z5lZ0iZuY+VVeJXjfZNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Friday, May 31, 2024 18:49
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: create amdgpu_ras_in_recovery to simplify =
code

Reduce redundant code and user doesn't need to pay attention to RAS details=
.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 13 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 14 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 31 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 ++
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  5 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  3 +-  .../drm/amd/pm/swsm=
u/smu13/smu_v13_0_6_ppt.c  | 12 +------
 7 files changed, 29 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 2ba8c4d5dc76..1811c7ba9bdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6325,20 +6325,11 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_d=
ev *pdev)
        struct amdgpu_reset_context reset_context;
        u32 memsize;
        struct list_head device_list;
-       struct amdgpu_hive_info *hive;
-       int hive_ras_recovery =3D 0;
-       struct amdgpu_ras *ras;

        /* PCI error slot reset should be skipped During RAS recovery */
-       hive =3D amdgpu_get_xgmi_hive(adev);
-       if (hive) {
-               hive_ras_recovery =3D atomic_read(&hive->ras_recovery);
-               amdgpu_put_xgmi_hive(hive);
-       }
-       ras =3D amdgpu_ras_get_context(adev);
        if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3)=
 ||
-            amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4)=
) &&
-           ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery))
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4))=
 &&
+           amdgpu_ras_in_recovery(adev))
                return PCI_ERS_RESULT_RECOVERED;

        DRM_INFO("PCI error: slot reset callback!!\n"); diff --git a/driver=
s/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 68505eaa92f9..fb5fc1fe6ad0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -505,9 +505,6 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, =
int xcc_id)  {
        struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
        struct amdgpu_ring *kiq_ring =3D &kiq->ring;
-       struct amdgpu_hive_info *hive;
-       struct amdgpu_ras *ras;
-       int hive_ras_recovery =3D 0;
        int i, r =3D 0;
        int j;

@@ -532,16 +529,9 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev,=
 int xcc_id)
         * This is workaround: only skip kiq_ring test
         * during ras recovery in suspend stage for gfx9.4.3
         */
-       hive =3D amdgpu_get_xgmi_hive(adev);
-       if (hive) {
-               hive_ras_recovery =3D atomic_read(&hive->ras_recovery);
-               amdgpu_put_xgmi_hive(hive);
-       }
-
-       ras =3D amdgpu_ras_get_context(adev);
        if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3)=
 ||
-            amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4)=
) &&
-               ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery=
)) {
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4))=
 &&
+           amdgpu_ras_in_recovery(adev)) {
                spin_unlock(&kiq->ring_lock);
                return 0;
        }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 10cbcc0d1a1a..ff2d34dc9718 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1409,11 +1409,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_devic=
e *adev,
                enum amdgpu_ras_block block)
 {
        struct amdgpu_ras_block_object *block_obj =3D amdgpu_ras_get_ras_bl=
ock(adev, block, 0);
-       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
        const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_func=
s;
        const struct aca_smu_funcs *smu_funcs =3D adev->aca.smu_funcs;
-       struct amdgpu_hive_info *hive;
-       int hive_ras_recovery =3D 0;

        if (!block_obj || !block_obj->hw_ops) {
                dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",=
 @@ -1425,15 +1422,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_devi=
ce *adev,
            !amdgpu_ras_get_aca_debug_mode(adev))
                return -EOPNOTSUPP;

-       hive =3D amdgpu_get_xgmi_hive(adev);
-       if (hive) {
-               hive_ras_recovery =3D atomic_read(&hive->ras_recovery);
-               amdgpu_put_xgmi_hive(hive);
-       }
-
        /* skip ras error reset in gpu reset */
-       if ((amdgpu_in_reset(adev) || atomic_read(&ras->in_recovery) ||
-           hive_ras_recovery) &&
+       if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
            ((smu_funcs && smu_funcs->set_debug_mode) ||
             (mca_funcs && mca_funcs->mca_set_debug_mode)))
                return -EOPNOTSUPP;
@@ -2444,6 +2434,23 @@ static void amdgpu_ras_set_fed_all(struct amdgpu_dev=
ice *adev,
        }
 }

+bool amdgpu_ras_in_recovery(struct amdgpu_device *adev) {
+       struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev);
+       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
+       int hive_ras_recovery =3D 0;
+
+       if (hive) {
+               hive_ras_recovery =3D atomic_read(&hive->ras_recovery);
+               amdgpu_put_xgmi_hive(hive);
+       }
+
+       if (ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery))
+               return true;
+
+       return false;
+}
+
 static void amdgpu_ras_do_recovery(struct work_struct *work)  {
        struct amdgpu_ras *ras =3D
@@ -2807,7 +2814,7 @@ static void amdgpu_ras_do_page_retirement(struct work=
_struct *work)
        struct ras_err_data err_data;
        unsigned long err_cnt;

-       if (amdgpu_in_reset(adev) || atomic_read(&con->in_recovery))
+       if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
                return;

        amdgpu_ras_error_data_init(&err_data);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 437c58c85639..37e1c93c243d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -952,6 +952,8 @@ int amdgpu_ras_put_poison_req(struct amdgpu_device *ade=
v,
                enum amdgpu_ras_block block, uint16_t pasid,
                pasid_notify pasid_fn, void *data, uint32_t reset);

+bool amdgpu_ras_in_recovery(struct amdgpu_device *adev);
+
 __printf(3, 4)
 void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
                                const char *fmt, ...);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 825786fc849e..04533f99f1e3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1863,7 +1863,6 @@ static int aldebaran_mode1_reset(struct smu_context *=
smu)
        u32 fatal_err, param;
        int ret =3D 0;
        struct amdgpu_device *adev =3D smu->adev;
-       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

        fatal_err =3D 0;
        param =3D SMU_RESET_MODE_1;
@@ -1876,8 +1875,8 @@ static int aldebaran_mode1_reset(struct smu_context *=
smu)
        } else {
                /* fatal error triggered by ras, PMFW supports the flag
                   from 68.44.0 */
-               if ((smu->smc_fw_version >=3D 0x00442c00) && ras &&
-                   atomic_read(&ras->in_recovery))
+               if ((smu->smc_fw_version >=3D 0x00442c00) &&
+                   amdgpu_ras_in_recovery(adev))
                        fatal_err =3D 1;

                param |=3D (fatal_err << 16);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index fa78665458a7..d1766a603bb9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2786,10 +2786,9 @@ static void smu_v13_0_0_set_mode1_reset_param(struct=
 smu_context *smu,
                                                uint32_t *param)
 {
        struct amdgpu_device *adev =3D smu->adev;
-       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

        if ((smu->smc_fw_version >=3D supported_version) &&
-                       ras && atomic_read(&ras->in_recovery))
+           amdgpu_ras_in_recovery(adev))
                /* Set RAS fatal error reset flag */
                *param =3D 1 << 16;
        else
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 15c0aa0ad443..c1d7528a6dc8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2573,24 +2573,14 @@ static int smu_v13_0_6_get_thermal_temperature_rang=
e(struct smu_context *smu,  static int smu_v13_0_6_mode1_reset(struct smu_c=
ontext *smu)  {
        struct amdgpu_device *adev =3D smu->adev;
-       struct amdgpu_hive_info *hive =3D NULL;
-       u32 hive_ras_recovery =3D 0;
-       struct amdgpu_ras *ras;
        u32 fatal_err, param;
        int ret =3D 0;

-       hive =3D amdgpu_get_xgmi_hive(adev);
-       ras =3D amdgpu_ras_get_context(adev);
        fatal_err =3D 0;
        param =3D SMU_RESET_MODE_1;

-       if (hive) {
-               hive_ras_recovery =3D atomic_read(&hive->ras_recovery);
-               amdgpu_put_xgmi_hive(hive);
-       }
-
        /* fatal error triggered by ras, PMFW supports the flag */
-       if (ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery))
+       if (amdgpu_ras_in_recovery(adev))
                fatal_err =3D 1;

        param |=3D (fatal_err << 16);
--
2.34.1

