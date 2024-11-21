Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C2FD75BA7
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 03:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D1D410E848;
	Thu, 21 Nov 2024 03:47:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oMOGOMV6";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AFC710E848
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 03:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+BvwLKSVYWBFhioOKQ/wkF+gsvDIPDH14gtjHv06Zmfn0inVp3k/dRPMfg5agtaOBE38QQHkJ9cRllocz63u5QKJ904flUbWn93L/4rjXj3aHBUGhiV0+iT0Q2H7xUT1m5dVnsMFANgUItyD9lpSE/AIlwHfwxp/QM05hBwzcdGqKSDZH5MikaWQRHQk1wYOnoWJUrUhYzCg8iM5yuc1M+ZwNv5Rv8bK4Ghrgoeq6F2rLGrCDSXQowkhTBxCueMtqmp+eaQm5umaECiTLghLBS6hl1qPsurEzozmCJ3qHCpBblpSbljB7mI9SrddgFbSArnrYhL7gnf9kIf9O3wAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lG3eQQAMM6CAguhGVX0gXLJO5+l2CrCJugd7f6Ufd4=;
 b=Pqwm0nA6UiMopEh3VMYKpKITnCNTbmddYgKZ3Gn2lcWKO05FfbQoUUytdTwDhMGvWDeiOnZfgNu9+EEUzymJb/T23l7apxho/1E4NUzb30fWR+PDi2aagfmravHCVV22k/F5BuH0DfQoVSXOHtt5wwEclUTDMD9BO77cykFRwN9iqgzIc5vQ9PV0Y3+80rC3fZKY4TAG+ujsBqSasvttjoqGka4wn/JTj20uN84kdYZl6tu4GGZEm5qRXR1ioGgVYE3ClgrJe4zpVRGwABKUsL8PDK3vHrpW0Jm4PuPoeLwydvYo6NvYzFHQPjJgn4O875otwjZKOrxKbi6GSjP+Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lG3eQQAMM6CAguhGVX0gXLJO5+l2CrCJugd7f6Ufd4=;
 b=oMOGOMV6S0QSXT0yeR8nVQs927obxmnRqdY5NFbfKgd5gvQyiArlUUzUNSsfRTAJlvXv9PEvhfEXVjuVSCR0uEdVB5/oeruVv6azFPSrUyPH4q+ZeQ0UR1UtSmlfynitXse21x9mLblQXLONvXwHdltng070G5IuL2tMw1nEYAA=
Received: from SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Thu, 21 Nov
 2024 03:47:28 +0000
Received: from SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::cb36:d7c3:c354:e74b]) by SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::cb36:d7c3:c354:e74b%7]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 03:47:28 +0000
From: "Fan, Shikang" <Shikang.Fan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deng, Emily" <Emily.Deng@amd.com>
Subject: Re: [PATCH v3] drm/amdgpu: Check fence emitted count to identify bad
 jobs
Thread-Topic: [PATCH v3] drm/amdgpu: Check fence emitted count to identify bad
 jobs
Thread-Index: AQHbO8eKDpmXcpImBE+1rvokd4EljLLBGBmK
Date: Thu, 21 Nov 2024 03:47:28 +0000
Message-ID: <SA1PR12MB7343A9D5E2E97485D3FF9AA7EB222@SA1PR12MB7343.namprd12.prod.outlook.com>
References: <20241121034312.1010449-1-shikang.fan@amd.com>
In-Reply-To: <20241121034312.1010449-1-shikang.fan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-21T03:47:27.952Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7343:EE_|SA0PR12MB4463:EE_
x-ms-office365-filtering-correlation-id: 46165db2-2d0f-4a64-fb38-08dd09df3853
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?1ulYCGs8zff16nWpF8+AX3beA7sKQ562x2VtxK9n81UyOFMKG7U5x3TvSg?=
 =?iso-8859-1?Q?XaHF+fRfeHvb+5pnAAQN9TQH580JwCMbBEmEeaNvDcwD9rUNDPtrq/Fjib?=
 =?iso-8859-1?Q?hiImW3zJy4bpqqEkiY8r8ZHnKIJD9NSt+wwfwxeSIdSafwaEoT+fjS0jhJ?=
 =?iso-8859-1?Q?hA8HjqXlzMl/jPiozJlzFh3BzKs5GX2f/zxe4j54vXKqKwsuLiEki8pk3D?=
 =?iso-8859-1?Q?yMsACACI9vOy3Bj0NPpvZbYuCxicn1qYUiPqu0qj4qsW7hN7XqCHNS6mmb?=
 =?iso-8859-1?Q?JMFGFxBSDG4GlCkhLCOhizVfYIETN9e1je2C1zMiitWPc+m8YNtLPKqc8W?=
 =?iso-8859-1?Q?XcM9QLTtHk8a5gS15jESLcOcmo+kZXHN1jKYjJobJYtR6nJ5+sCtMrFgI9?=
 =?iso-8859-1?Q?MEJLsNGNSzBJfT2MVl5rXty1UZtjoDWY8mHprE2+JORikCrHsuseysVjIG?=
 =?iso-8859-1?Q?Q/abir7MxfW2Jo+HLa92k/tiIGbLWJY9k5++XzPnW24u2ZXeF+oXwxxmkh?=
 =?iso-8859-1?Q?VHD2z+RD20V4oNjZzSjNxav/jZm9shzc4C4Pi1shBlhsbHHH8wReekMwGH?=
 =?iso-8859-1?Q?hUAWBRj/oVqZdMIsV3JfFCHemb35jl3ebTKji7Mx7vDHIbSGEnHyhtAv9W?=
 =?iso-8859-1?Q?eqwKzNtRTPCEjV2ne3GJkobweLvAX4IR/C2IxHrPHwno313E2gcA6LUMSZ?=
 =?iso-8859-1?Q?lDhMXMtiGgtlviexmqEoHR5eighnjpTPxhBUnHjLR7wIQcLBE0LB9cjD9/?=
 =?iso-8859-1?Q?DIIcJiSs+7MTF04zAoXu610E3oHnFp+3UdQaXwR5Jptw2bQ8mBusmefHhi?=
 =?iso-8859-1?Q?RO1tMIa5UZH/ta2GZjfq8EhEt/xwKuxiHpF7LDoANSBbdEzMwkLgY7yrkC?=
 =?iso-8859-1?Q?ypCtKkw57pIH4arkvdKWURqeAyEgom6uw+uz7fft/G1DzeQyL1xA9oksmJ?=
 =?iso-8859-1?Q?TzpX6K74Gtk5OmeVxVqAcwlsQ8WYeJTM3kMSo44KDlaP5xMrjAC5eDJyXP?=
 =?iso-8859-1?Q?Ao7SrLCIN0tQrsR7caBCPBkwW0tESSzG/dO0mSrppRU4kOPgLVkxzQ6pqg?=
 =?iso-8859-1?Q?dgXP+k5odjCRna8pKOF96UBRUogItsw2jowoEuBXSWPlQiWaIB0+4odNOd?=
 =?iso-8859-1?Q?YVrhiIe3CIxDL83SxU+yVHPWvFX4ibfiKYZSZMAM00DGq3OVB4vzEZy6N3?=
 =?iso-8859-1?Q?2Qq0FnkmAwBWyxxwZ3bWC94VCBdIrKPBKStQMh+HLbLXjZEu/yu8GGasfE?=
 =?iso-8859-1?Q?MvTafUKUsNKJxOfm5PXPkKIIiesNXFluhpXzR0OV9CEELap3spCnP6mrKx?=
 =?iso-8859-1?Q?xUQ7gtDSS9DYe8O42GFCNI1FyLdFSyxp2ePA2IWbkRHwiLZM4I6H8E24ex?=
 =?iso-8859-1?Q?waOlw+cDe1AA68eXXB/vhXKmMMepupkHqg7ygZcxhePbqY/1c+reE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7343.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pXNX64PvX6mZGHi+CdYTbTWaTI+lIACaGqKhRDhjb57qbr/G+ydn+i8cTw?=
 =?iso-8859-1?Q?pSuM7fhsKdXm1kPF3LFUSGmRgHn40PB3vuxj0rpFxYv2A19LF77DH310dL?=
 =?iso-8859-1?Q?q+QSFxaKVBd4DYGfZJwO/BHq5KBfYCiZExoBfu2X4bS2hQfgdDIBOuFtQs?=
 =?iso-8859-1?Q?f75jLoPkyS2/1ivnRBCg1VjrxqVm22o+cJKEoklwsYDH4avsE2YoL7Y83+?=
 =?iso-8859-1?Q?Rd70FusEHTaG00ZOCb+Ov2dOsouWkCtP59yvaxCoUG8Q7Elqa9gaau+JYz?=
 =?iso-8859-1?Q?UJ5si1wLNMoQR/1EeAqm3jPI+0vaPMHx6xDP74s7spcmN2S3ARvY/J7wrh?=
 =?iso-8859-1?Q?Wcd5bdmX7kN928m9Dd9jsblXpLtIaxKNgoXtyu0tjRaeaBhT4nc/yb5DW1?=
 =?iso-8859-1?Q?aKCHPqzw8j9n/jPxqjgMidY5yOx1qyZEPzRSgWTSVl+8Kj+ykYLvm5QVPf?=
 =?iso-8859-1?Q?gTPqEjgHiR2o4ueFC4buEMlOcVw9nEEkswno6b+u/1Jf+88Hxh3Lg8qYWR?=
 =?iso-8859-1?Q?Gy8G3AcTJMe6SJRLhp8EYiSyhAwwi3AnfPuS/3cirhdB1Wh5XNPxtv+iyV?=
 =?iso-8859-1?Q?kOw6d+WTqPTC7tjH6qA7ypKFcF+T7L06oxDYZarBzxAF53ql0vrAi/FF8z?=
 =?iso-8859-1?Q?Ma/v046WPqLQEeoqo8AVGq8of/Ab/f7yHoffIrTLrxR2BHUie5ve8Tgbt3?=
 =?iso-8859-1?Q?QtlFeoKklQ/RdF7B6Bw7BChahgv2Lxys/tltAU8eP3AYqQ11+o3UnWibj0?=
 =?iso-8859-1?Q?CDNRIPUuLN9z5KLBs7kYl6eNdV4dwHbjO2qujSFOq1i56x7jZJEMgSvMyu?=
 =?iso-8859-1?Q?5q6TWRm2kaP8RZHeRHIhjWIkUs19ZlD0iocVx5Yn57dIZrv8VPw5ObCThV?=
 =?iso-8859-1?Q?hAMFGhRnTFlb9RsSxyO/LwkgzrRZZYKhpNwMtBMj+rjGfrvU3nvPxR1Wzg?=
 =?iso-8859-1?Q?SChZ25Mgs3gAOstyLt6wvOXi922jTX8oeT5hPZ5XTdM05SRHkjtyIT/SdT?=
 =?iso-8859-1?Q?tZPmrpospsgfAaw0MW8p+lPfnnNGX5U7dF9oxxMg7AJlTVTedlqeJPjP+c?=
 =?iso-8859-1?Q?XCZPdEJp4yN/cHnU8B1rqEgKouo9ZuE0GIj7APx/SsGKvgV23y7MngJiB3?=
 =?iso-8859-1?Q?XKzUZ6rU/2HLwRVUQRBIun4xcsHOeIym8fhk7ta8sr3fqlA8CKV4kquDR5?=
 =?iso-8859-1?Q?8c3pfq1HdAiFSuxnq/Pil/N6NGGJTiXXBSl30uYd9Sc9QPaeSsyb1TY47C?=
 =?iso-8859-1?Q?MMtWey32RWcue5ehlj5eduIhIUq4oJPaJ/M3ePn8pdp+QkGqAdwl7BIg2Y?=
 =?iso-8859-1?Q?P9a0yFTwttYdEoEjf0DNd68PGyrfqf59tZ841xNsuHFv+8FUGP1MzHvWR3?=
 =?iso-8859-1?Q?wHc9K394dSreGhcY9SId496yBxg5gCrA49GdmOMZYzK54VbFyZRZ5qZcUs?=
 =?iso-8859-1?Q?A/hnBWMYV2KYPpX64JAqPmZ2/1U1/iFlquO0vXQIOxME1yG6F8ikRyPrVA?=
 =?iso-8859-1?Q?3a5eK7JsJ3e+2BpgrgaiapJTx2MytObVi5exEJAC/vQamTfLI2tjgUis9K?=
 =?iso-8859-1?Q?M6Coqsi7GxbTb69coI/UiEdpnl4sbbyF30hXEGwiTui1Qx9CWse+VJ16dQ?=
 =?iso-8859-1?Q?8UAGBSKx/A++A=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB7343A9D5E2E97485D3FF9AA7EB222SA1PR12MB7343namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7343.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46165db2-2d0f-4a64-fb38-08dd09df3853
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 03:47:28.3427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPBgY41vYYyLGLw0jDwUsyJvpY3A9JHDbeOdH2vUQ2TbV/vHHjsAFjBcaBT6/nBcTtLwGhBZIlFHNK/J9ibnKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
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

--_000_SA1PR12MB7343A9D5E2E97485D3FF9AA7EB222SA1PR12MB7343namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

ABANDON this patch. Need further modification.

Regards,
Shikang

________________________________
From: Shikang Fan <shikang.fan@amd.com>
Sent: Thursday, November 21, 2024 11:43 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Fan, Shikang <Shikang.Fan@amd.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH v3] drm/amdgpu: Check fence emitted count to identify bad j=
obs

In SRIOV, when host driver performs MODE 1 reset and notifies FLR to
guest driver, there is a small chance that there is no job running on hw
but the driver has not updated the pending list yet, causing the driver
not respond the FLR request. Modify the has_job_running function to
make sure if there is still running job.

v2: Use amdgpu_fence_count_emitted to determine job running status.
v3: Remove the timeout wait in has_job_running

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index b3ca911e55d6..ff9995c0f764 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5222,15 +5222,19 @@ static int amdgpu_device_reset_sriov(struct amdgpu_=
device *adev,
 }

 /**
- * amdgpu_device_has_job_running - check if there is any job in mirror lis=
t
+ * amdgpu_device_has_job_running - check if there is any unfinished job
  *
  * @adev: amdgpu_device pointer
  *
- * check if there is any job in mirror list
+ * check if there is any job running on the device when guest driver recei=
ves
+ * FLR notification from host driver. If there are still jobs running and =
not
+ * signaled after 1s, the hardware is most likely hung already, then the g=
uest
+ * driver will not respond the FLR reset. Instead, let the job hit the tim=
eout
+ * and guest driver then issue the reset request.
  */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 {
-       int i;
+       int i, j;
         struct drm_sched_job *job;

         for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
@@ -5239,11 +5243,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_dev=
ice *adev)
                 if (!amdgpu_ring_sched_ready(ring))
                         continue;

-               spin_lock(&ring->sched.job_list_lock);
-               job =3D list_first_entry_or_null(&ring->sched.pending_list,
-                                              struct drm_sched_job, list);
-               spin_unlock(&ring->sched.job_list_lock);
-               if (job)
+               if (amdgpu_fence_count_emitted(ring))
                         return true;
         }
         return false;
--
2.34.1


--_000_SA1PR12MB7343A9D5E2E97485D3FF9AA7EB222SA1PR12MB7343namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
ABANDON this patch. Need further modification.<br>
<br>
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Shikang</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:11pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Shikang Fan &lt;shika=
ng.fan@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 21, 2024 11:43 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Fan, Shikang &lt;Shikang.Fan@amd.com&gt;; Deng, Emily &lt;Emily.=
Deng@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3] drm/amdgpu: Check fence emitted count to identif=
y bad jobs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">In SRIOV, when host driver performs MODE 1 reset a=
nd notifies FLR to<br>
guest driver, there is a small chance that there is no job running on hw<br=
>
but the driver has not updated the pending list yet, causing the driver<br>
not respond the FLR request. Modify the has_job_running function to<br>
make sure if there is still running job.<br>
<br>
v2: Use amdgpu_fence_count_emitted to determine job running status.<br>
v3: Remove the timeout wait in has_job_running<br>
<br>
Signed-off-by: Emily Deng &lt;Emily.Deng@amd.com&gt;<br>
Signed-off-by: Shikang Fan &lt;shikang.fan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++++--------<br>
&nbsp;1 file changed, 8 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index b3ca911e55d6..ff9995c0f764 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -5222,15 +5222,19 @@ static int amdgpu_device_reset_sriov(struct amdgpu_=
device *adev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * amdgpu_device_has_job_running - check if there is any job in mirror lis=
t<br>
+ * amdgpu_device_has_job_running - check if there is any unfinished job<br=
>
&nbsp; *<br>
&nbsp; * @adev: amdgpu_device pointer<br>
&nbsp; *<br>
- * check if there is any job in mirror list<br>
+ * check if there is any job running on the device when guest driver recei=
ves<br>
+ * FLR notification from host driver. If there are still jobs running and =
not<br>
+ * signaled after 1s, the hardware is most likely hung already, then the g=
uest<br>
+ * driver will not respond the FLR reset. Instead, let the job hit the tim=
eout<br>
+ * and guest driver then issue the reset request.<br>
&nbsp; */<br>
&nbsp;bool amdgpu_device_has_job_running(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MAX_RINGS; ++i) {<br>
@@ -5239,11 +5243,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_lock(&amp;ring-&gt;sched.job_list_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job =3D list_first_entry_or_null(&amp;ring-&gt;sched.pending_lis=
t,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job, list);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (job)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_fence_count_emitted(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SA1PR12MB7343A9D5E2E97485D3FF9AA7EB222SA1PR12MB7343namp_--
