Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3F1C5DF70
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 07:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE0110E204;
	Tue, 18 Aug 2026 07:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uZgNoBUZ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E9210EA1C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 07:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgNMbpZeIQmgXxm3OfKy1dtG/JlEkegv37qjDZZoDVhZwwA6E/G1cr3mjT720fz5A7bQJB0RQ3/wJRPOk6TSyIN0TwDtte82jQUoMM67l/qq/Q3CaQ7KTgB8X9XAK4m+b3iUKOBQ9yDovYn3XADSTXUqWGZ+WV5koTzpR3nMQ7a1krQMYNdgOpwzUZYnnfSYHDAk03nJqij6b1K70Wi1Fzq87/jWbuDGu1uxEs7Xdd6fX9ZhDrfe2nIWPsy/Q3uFNhF1JDTYD3bB45NgKmt82XksGAyshLMMSRKzSBGrXR18QrZ/mC6NkfdpNOYVyRnT3uYMT2cO3G+mSUKLuY87+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2Icl6GFf2BFP1x/JDP5imuj7opt9cdheeJvSFdPXuM=;
 b=hpAQDkCmqg1n02B7179oDqowv62g3jdTI/k4wEffd2nz1v+YWpTzW6t7U+XFVx+px162ApkWN/BUDDIyxsZJFXIYtESTKyH2JZKUpHC3gGz74dqUNa0o6dgsXhUnPwddC585SR02MwqhPGRUVI9BukTrDyhKbJP+djD3MrM69SBNlvK5D5mNFPS6Bbjpa7Zd1zvAulBccOInQJR6HTOMeM6HVQlEroP6Gg12g90E+49zBbPvH2Vzh3KsVM3lJ4no/zAH6FCTUPGcLAA3/ZE2RET7fIb/2gsMwRODuJqQfTD0EeNcqZ2+3su1VkaGLCpAVVJ8TbHR8mzmRUciTzIOjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2Icl6GFf2BFP1x/JDP5imuj7opt9cdheeJvSFdPXuM=;
 b=uZgNoBUZ12CxZOpdkfVbflzft+vCWxuuuKU9gytgE3dyhjx8fVKdGrHxyMvzHTbtaCqNzTwVAz4TlFAnFvc1v/mwM++aK9DPTZMgexqYaq2UOCn2BnoZT5tHF0HW578lDx2xBBjif8Cg9VzFpRDDlQwj6mYy5oeIsrcAbWfutBk=
Received: from SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 07:41:19 +0000
Received: from SA1PR12MB6799.namprd12.prod.outlook.com
 ([fe80::6d46:bf1d:4a60:76c5]) by SA1PR12MB6799.namprd12.prod.outlook.com
 ([fe80::6d46:bf1d:4a60:76c5%7]) with mapi id 15.21.0315.011; Tue, 18 Aug 2026
 07:41:19 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: Fix SMU messages after system resume for
 smu 11.0.x
Thread-Topic: [PATCH v2] drm/amd/pm: Fix SMU messages after system resume for
 smu 11.0.x
Thread-Index: AQHdLsjuuKZdlzJl9UiI3bhLs75fubajXFSg
Date: Tue, 18 Aug 2026 07:41:19 +0000
Message-ID: <SA1PR12MB6799FDD746911004CEA124228EA62@SA1PR12MB6799.namprd12.prod.outlook.com>
References: <20260818042008.287779-1-kevinyang.wang@amd.com>
In-Reply-To: <20260818042008.287779-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-18T06:43:59.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6799:EE_|SJ0PR12MB7007:EE_
x-ms-office365-filtering-correlation-id: 75d2aedd-cbaa-4b60-ca6f-08defcfc17e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|56012099006|10067099003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: qvCZcc/re0Imb5OfqkFD3b1PJaYdXh0J5EQ8eZUhKAwb9/wEgVZzW+OkFEWDT1eDkzcDWy2LyvxIDFxdd8fFsWXxG99nGodOAzZh3kH1fgBmBhNqNYo+jHTbhOxz06q4+TpkoEu0S79PKcX4Dsar6GUV520ytSe4aI7ETQ2tQwuKmmZPYsLYCNe9QGMQPgKBWugAU7gZtMIVaurtymWEjC6Tc9id1E/8X50iVJ8d2eA8szdj9qi3Xs/JIq5GL/N4Zn1kSAogsx8gXcloEzOvxJcrkXSKGjHWRSKkXUouccuiQLWetO6voEgQqz2S4GGi//4hzQ+HVexbEeuGZVrF7HgoQ0cfX8iHq0iwaISP9ZtLpqMJJlsHe2ZnpMtUnEeX9cAu+I7Sc6f7ItrvScywEqBUv22xZzd9jzYImrzV9AlBsHRG/Mfv9a1J/IN+LWn4+Z4qaKazxdXeoYXZent5F1SoA19RgTMCAEen0+39HIo3w98SzlLTChXGQqY5bawtE9cwHm3Fr0BgFRtyODff2Ww3zYjKCJaU5ulZAnOKU4t7Nd9cJHjkVB6cWs/70lxfiWm3GwcFpqYYfOiscmaJVKqwd7Qb2FiK1c9/ocY32HqwoFq/KIleiwBEK65LsICSx6PsFfrVHu2rn6DwJxcATpXFzizatPgWX+Ic+/bAEtc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB6799.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h1UPv4iVoWUgZl8T7chTjhrIwSFimj6ZtV6Sdqf9iRPQraZTGPRPi+tgKRYi?=
 =?us-ascii?Q?HEMUpyugNoN7mjo0WfM38vK3WK86d7KWlimmGLiYivYel4GhDzvWDpoKiK7d?=
 =?us-ascii?Q?RtcJjBwS28kNjM7hRsmg78qV0C627YzdlKTRTB5Be1Oipl7tJrP8t3TRwkzS?=
 =?us-ascii?Q?wEKo98Iue54Y1v7WhsyGLXi7T2byKmUnHXaedcpuZT+wlZSiRjiq/lue7iF3?=
 =?us-ascii?Q?yqci8mO65WwdJnsl4/kJpLATSL1xHSioef37obKlEomEyt/GD46vO0mprZaA?=
 =?us-ascii?Q?lyghGxxoJEUKpw6bYmTaEa02RYB4MSmPyQonW8yoclCvzhW4qgT1TKqa07Wt?=
 =?us-ascii?Q?dYSIrtNSFnc21lMzxJ99dh3fc/C76olAmAEnKvLj3ldMXOo/3BIkBQJ/ZyQP?=
 =?us-ascii?Q?UfdWgK2oxWUf+yrKGkXFwygdVSinqgSh5J54OnY88s7XMNYqdYxaJlXVUfuJ?=
 =?us-ascii?Q?n2GCZkEO6UkKYLo8z4vMecABY7Vw7dBYqfhY7R43GjN7gnKEmGZwvHjXWaOS?=
 =?us-ascii?Q?4Jz3J3dqZYZ24ifa6BhtN0ZujPrQlKucQHvyRzDY/eJYM1YwLFRCgXs7ZDCZ?=
 =?us-ascii?Q?kL9UFDFCIoR8MPB3Adyr5yNXHCg21oBhPwDNT0nK22QcxUU/4qyY/srrJg8s?=
 =?us-ascii?Q?yxZd4D/biNhjznHCBpVV7P0yAnjRM+DCggspyXqM7MOFWkLmMNDpu1u18qG8?=
 =?us-ascii?Q?bRJnLsk/pAA2jZvn0nEHJbd6UXsM0Ex1AXrOg1H1f1SCCcdtgAz3s6ipL0yO?=
 =?us-ascii?Q?z1f0Ka6/YhDNKiOAjQ47E0gu9ojBNNrEW8BuTcCSXbPaMggtt/iu0g8FFUyu?=
 =?us-ascii?Q?b9XZRT0dLrYAGGGKRIAbJfnceeQamUwh/mLkoAc3u6Q6Et/mXCQv/Jp7U8tA?=
 =?us-ascii?Q?sNMt1XMn7FME2YOkGjVQ3ceGfQ9lG/n5f9ljY6ad1amf+2dnVO2yfL7l0bHo?=
 =?us-ascii?Q?YC2+ioEvfnCNR+frw++8j+rcFbAiTcQzX8G+elTym6/+/XzroxRU1ew/6vC4?=
 =?us-ascii?Q?tQMuBYsT0kneEUe1SINKgcomFVNvsPrFx9JbMB2AcsklLHxU+tVMLnlVqHmr?=
 =?us-ascii?Q?n6Eqcn3Rn3V5Fta8n00lcDd6dNXhhxoMk70Wlx32jT6otKCKNkTKmge55jCt?=
 =?us-ascii?Q?2jg/PtcFYfzVcZM6C+fOCfLx2pmlcWyDmfsmUuUL5GLt1AHWLotPjL7DXTRw?=
 =?us-ascii?Q?/o9oahuYqKjLn+woam7+IhkQwJyDgBTl0Dvioixv755scNbB0JvGgltNn9CS?=
 =?us-ascii?Q?h3A8cGfNaSMVwBN298l3f73355VZzFdW98Is5guoW5oIwPS6BNJCE9VoV8oY?=
 =?us-ascii?Q?+yoOzGwS9oVpHjqZVI2H0AjUsYbXxjdjCkLNPWRc4pf23WbqKTAHLmm40C9p?=
 =?us-ascii?Q?TRpVsjWsjAE3DM7QbgzJcqMlItg6/KoetGVTwFnvU6lfEr9QHIFFi2tDfFsx?=
 =?us-ascii?Q?2FR4PI+hLwdeo0PXIVZtvB3O5nQio/rQdiwxZwkrcD3jk++6ANbN3Gy02UXK?=
 =?us-ascii?Q?/OUiMpC91U1lLZs+Ix8/BTXmM72f+SE/VFEraC366a2akB2qwu7ghysOE6oE?=
 =?us-ascii?Q?rnFwQwfot3n+KCy2I2E6KGtVxe3PPabqnzG4qb9AcO5CN85P+9TnF6FNb3uU?=
 =?us-ascii?Q?TiclaJt54k9pAoV+ROo0o9iohWmmAuPQc3FwkughMQt+JKSFhrX2yzIaApli?=
 =?us-ascii?Q?d6kZt7dkh+MVLPfP4K8QeS5zgufmBMQ6hFcQkCOF94fecXZ7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6799.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d2aedd-cbaa-4b60-ca6f-08defcfc17e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 07:41:19.5993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ucsnWJajTs31H6drPzDSl62umeHgV7DOnqFjfmgxWSK5hyTI2jkO4IP5erC+T0Cb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007
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

AMD General

This issue happens in runpm resume, so need to remove the comments:
amdgpu_pmops_resume()
`-- amdgpu_device_resume()
    `-- amdgpu_device_ip_resume()
        `-- smu_resume()
            `-- smu_smc_hw_setup()
                `-- smu_run_btc()
                    `-- RunDcBtc fails

And loading fw twice is a workaround, might need a root cause in the hardwa=
re in the future. But the workaround is fine.

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, August 18, 2026 12:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH v2] drm/amd/pm: Fix SMU messages after system resume for sm=
u 11.0.x

SMU 11.0.x can retain an unfinished command across system suspend, causing =
SMU messages such as RunDcBtc to fail during resume.

The original failure path is:

amdgpu_pmops_resume()
`-- amdgpu_device_resume()
    `-- amdgpu_device_ip_resume()
        `-- smu_resume()
            `-- smu_smc_hw_setup()
                `-- smu_run_btc()
                    `-- RunDcBtc fails

v1:
- Prepare MP1 for unload for an active system suspend.
- Restore PMFW context after the normal PSP resume load. The initial
  centralized load preserves PMFW-before-TMR ordering; a successful MP1
  unload additionally requires the post-TMR context reload.

v2:
- Snapshot the runtime PM state at system-suspend entry.
- Exclude runtime-suspended BACO entries from the MP1 unload and PMFW
  recovery transaction.
- Mark the successful MP1 unload in PSP to order the post-TMR reload.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5620
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 11 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 11 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 40 ++++++++++++++++++++---
 5 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 070986b03fb8..71606dd2d6fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -860,6 +860,8 @@ struct amdgpu_device {

        /* s3/s4 mask */
        bool                            in_suspend;
+       /* runtime PM state snapshot at system-suspend entry */
+       bool                            in_runpm_at_suspend;
        bool                            in_s3;
        bool                            in_s4;
        bool                            in_s0ix;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 845160d2c516..8c7df6b4e168 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2803,10 +2803,15 @@ static int amdgpu_pmops_prepare(struct device *dev)
        struct drm_device *drm_dev =3D dev_get_drvdata(dev);
        struct amdgpu_device *adev =3D drm_to_adev(drm_dev);

+       adev->in_runpm_at_suspend =3D false;
+
        /* device maybe not resumed here, return immediately in this case *=
/
        if (adev->in_s4 && adev->in_suspend)
                return 0;

+       /* System PM can change runtime PM state after this callback. */
+       adev->in_runpm_at_suspend =3D pm_runtime_suspended(dev);
+
        /* Return a positive number here so
         * DPM_FLAG_SMART_SUSPEND works properly
         */
@@ -2825,7 +2830,11 @@ static int amdgpu_pmops_prepare(struct device *dev)

 static void amdgpu_pmops_complete(struct device *dev)  {
-       amdgpu_device_complete(dev_get_drvdata(dev));
+       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
+
+       amdgpu_device_complete(drm_dev);
+       adev->in_runpm_at_suspend =3D false;
 }

 static int amdgpu_pmops_suspend(struct device *dev) diff --git a/drivers/g=
pu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 04f6ebf31cca..e252733a6f3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3512,11 +3512,18 @@ static int psp_load_non_psp_fw(struct psp_context *=
psp)
        struct amdgpu_firmware_info *ucode;
        struct amdgpu_device *adev =3D psp->adev;

-       if (psp->autoload_supported &&
-           !psp->pmfw_centralized_cstate_management) {
+       /*
+        * NOTE: The centralized PMFW load in psp_hw_start() must precede
+        * TMR setup. A successful MP1 unload also requires PMFW context
+        * recovery after TMR, so reload it for this transaction here.
+        */
+       if (psp->smu_fw_post_tmr_reload ||
+           (psp->autoload_supported &&
+            !psp->pmfw_centralized_cstate_management)) {
                ret =3D psp_load_smu_fw(psp);
                if (ret)
                        return ret;
+               psp->smu_fw_post_tmr_reload =3D false;
        }

        /* Load P2S table first if it's available */ diff --git a/drivers/g=
pu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index d80c85793e3b..540077b9f070 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -443,6 +443,8 @@ struct psp_context {
        bool                            boot_time_tmr;
        /* flag to mark whether df cstate management centralized to PMFW */
        bool                            pmfw_centralized_cstate_management;
+       /* SMC firmware reload required after TMR during system resume */
+       bool                            smu_fw_post_tmr_reload;

        /* xgmi ta firmware and buffer */
        const struct firmware           *ta_fw;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 559afdc5815d..8ff1cb1efc5b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2182,12 +2182,38 @@ static int smu_smc_hw_cleanup(struct smu_context *s=
mu)  static int smu_reset_mp1_state(struct smu_context *smu)  {
        struct amdgpu_device *adev =3D smu->adev;
-       int ret =3D 0;
+       u32 mp1_version =3D amdgpu_ip_version(adev, MP1_HWIP, 0);
+       bool needs_mp1_unload;
+       int ret;

-       if ((!adev->in_runpm) && (!adev->in_suspend) &&
-               (!amdgpu_in_reset(adev)) && !smu->is_apu &&
-                       amdgpu_ip_version(adev, MP1_HWIP, 0) >=3D IP_VERSIO=
N(13, 0, 0))
-               ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
+       if (adev->in_runpm || amdgpu_in_reset(adev) || smu->is_apu)
+               return 0;
+
+       switch (mp1_version) {
+       case IP_VERSION(11, 0, 7):
+       case IP_VERSION(11, 0, 11):
+       case IP_VERSION(11, 0, 12):
+       case IP_VERSION(11, 0, 13):
+               /*
+                * Prepare MP1 only for an active system-suspend entry.
+                * BACO retains the SMU firmware across runtime suspend.
+                */
+               needs_mp1_unload =3D adev->in_suspend &&
+                       !adev->in_runpm_at_suspend &&
+                       adev->mp1_state !=3D PP_MP1_STATE_UNLOAD;
+               break;
+       default:
+               needs_mp1_unload =3D !adev->in_suspend &&
+                       mp1_version >=3D IP_VERSION(13, 0, 0);
+               break;
+       }
+
+       if (!needs_mp1_unload)
+               return 0;
+
+       ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
+       if (!ret && adev->in_suspend)
+               adev->psp.smu_fw_post_tmr_reload =3D true;

        return ret;
 }
@@ -2279,6 +2305,10 @@ static int smu_suspend(struct amdgpu_ip_block *ip_bl=
ock)
        if (ret)
                return ret;

+       ret =3D smu_reset_mp1_state(smu);
+       if (ret)
+               return ret;
+
        smu->watermarks_bitmap &=3D ~(WATERMARKS_LOADED);

        smu_set_gfx_cgpg(smu, false);
--
2.54.0

