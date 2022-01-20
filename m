Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A3EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 09:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 822D410E268;
	Thu, 20 Jan 2022 09:47:40 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2116610E216
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 09:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5M9oH6ULI6tgV+107baKTovV6A3N5oV3Hk/yAHJyLqv2M7Aa3tHb0NYfNyAc5qMfypaTpz7M2FCbNGjbn6gISgsnbl4J6r80oojNVGAF6uHKX6DpzJojL9Pni3lQHXTqkSHuLV0tGFKehqZ4IyXoDK3Xfw+/ilu4vG5x4ybm5Jssqlce+5kh6iGn4AYjZCUO9I19wPde3Q3VWm3vqT83IP4d2AppR6uO4I5AW16+zKPw7KOiFxFHc9B7414kfkfyLheSNpadWqeHM24B8BL3YLwWZP8cpdnTHbn+Wm47CLbAcXj9ktxAZUKJkf8KVrL9dfwtQQASpYaCkcmR0yKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MR3cebxw4ensiZyvrWtoEG2TOpaOcpnB4cMl1IFDyNs=;
 b=KWII+AJn9HfMe+opFAENWU61gte3Oy4dpoAY/NBnp3rnRUJbXCl6oNCzwTP/xRE/w+2zOJrYx9d7l+3bW3VScUAVoHix/sWDsWXaNY/z1ehVU/HeSqx7ZN3OV77c2uIKG6Zs/Y8XWTha7sV3hUhQAtvW6t0zHlDSo1vSz7QOAN3JqeewcQiQYvppWqCkC9KPi0FIUyjpuu4NpScWgTAe4RJLyg/NvFET7JLMtFChEbb1ppSVpDs6nVaWcTQsgerdSndjC+qh1f+cA52Tkur1HdJinyboGQjzRn/HtcRU+wtkAAKNDQFjglF0lSXrXY2t9HwKD/cNR0SlFC91wd+lNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR3cebxw4ensiZyvrWtoEG2TOpaOcpnB4cMl1IFDyNs=;
 b=sDuXe2+e5CFu3mzVRnQreQcigaote1fzVo8VqHsTj2ss0EjUO9G9nrb1/MoFDZwxMnZPA35LAZr0jPagrEl95Y6JjCPuaAWPXMFdG5jsRD/GRYLg9QihDpFy8C50AC1BrRkWghaGeCFuN6YqfJ5lv0PrSTf5gtCddGMg9vrSGNU=
Received: from BN6PR12MB1555.namprd12.prod.outlook.com (2603:10b6:405:5::19)
 by BN7PR12MB2803.namprd12.prod.outlook.com (2603:10b6:408:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 09:47:37 +0000
Received: from BN6PR12MB1555.namprd12.prod.outlook.com
 ([fe80::1c48:a77c:d1d6:1f79]) by BN6PR12MB1555.namprd12.prod.outlook.com
 ([fe80::1c48:a77c:d1d6:1f79%12]) with mapi id 15.20.4909.010; Thu, 20 Jan
 2022 09:47:37 +0000
From: "Ji, Ruili" <Ruili.Ji@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdkfd: svm range restore work deadlock when
 process exit
Thread-Topic: [PATCH 2/2] drm/amdkfd: svm range restore work deadlock when
 process exit
Thread-Index: AQHYDVDm4xSf+0oTp0WrK6i4PuB/maxrqtWQ
Date: Thu, 20 Jan 2022 09:47:37 +0000
Message-ID: <BN6PR12MB15556B63522C647B73D711619B5A9@BN6PR12MB1555.namprd12.prod.outlook.com>
References: <20220119162246.21457-1-Philip.Yang@amd.com>
 <20220119162246.21457-2-Philip.Yang@amd.com>
In-Reply-To: <20220119162246.21457-2-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=917b1783-ed27-4d29-a496-72fe015b2c77;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-20T09:47:26Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cf63356-3ec1-4fec-e464-08d9dbf9e46e
x-ms-traffictypediagnostic: BN7PR12MB2803:EE_
x-microsoft-antispam-prvs: <BN7PR12MB28035BC5969E8327316AF3ED9B5A9@BN7PR12MB2803.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tUgBPNi+KqQ2HhJOkgm2Xd0S4A6jndP1uIVG064I7Qg9lVyj0Cmu9SB4yl+hgTX5pXePTV3/VZJJpuCMFjqt3qsnRM28U5BYAsUuUoJl9E9JX6hp3fEl4f+TV1zf7RQAKUy8HHOxxZT14ZPNEvdFxzXZpfzR0cbDgBYXaFUHMvBovbvvafch6zGDYa4Y2O++ggdFHwh4p/y4Rt0IsgLp3BfmfFGLJRNgoOmQordgIuvjMIPzhUkcQlT3zvlb/+3JxGYzWmDDYa0ixYxB6t+MLHFT7VMPPYh+wHQNqtoGj4994L/J1OD2diOqaKhIWUbqsN4/c6iW/jOLWdx9xVt1TYtzEw+zKYKMRi3YrturacRBQk9/CSUM3sM56DZwEn2pk0koqkpS8JTnBgkTznLC9Xgm267IURajq7MRJJxokf1NCkUhXveMYrjMOxikSge1H4xxrkJODQfCluh39etc7uc+5l9s1cSrS9SbsIGXscxr/ybTblHFM28GEIAAPl3BFxJTrC6hrqVN38WUoKS+TNTqTpqFOH3W9MdiiyYZny0FX8JY+EwZ8qmyt5l4AyRhatPv85zOcb+3fu2HAdgkDuN8Z+zk6sBf+XO5zo+p1auKt8jpHsUYD7+gJqlc0O8BByiNGaRqqJOfS0q+PGcbg1vBKdd7V5bruB7CfE7/8eDWdvnG2gLb+AHCWawhxjuHuPUYMNEuk35omRNVS7kAXw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(52536014)(508600001)(316002)(64756008)(71200400001)(55016003)(122000001)(9686003)(83380400001)(33656002)(86362001)(53546011)(66556008)(5660300002)(38100700002)(186003)(4326008)(66446008)(7696005)(26005)(66476007)(66946007)(8936002)(38070700005)(76116006)(2906002)(110136005)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RlI4cTlBdDlWWWdRTFVsUDA5RHVJKzRpWEhRc1hwcWNhQ2NmRVJkMUpD?=
 =?iso-2022-jp?B?YVdHQjkrcG9zUERnTGNMY2l2V2dSZERYM2ZJTDlBcWp4TnViYUpXTHo1?=
 =?iso-2022-jp?B?dlZTRmNQaDAyZTkvNkYrSWh4T1hUZ1lIcTFQVkhKTEdCOWpIODE4R0F5?=
 =?iso-2022-jp?B?WEVkZFNUVDFrOWJ0WUtjWkJpSjhIQkhWdTl2eDlMSVRmNmtFeWxLcHpC?=
 =?iso-2022-jp?B?ZVdZSmFRZjMrOThseHJVczA4ZDN0a1hKTlJvd1htem8rSGVUT082cTR2?=
 =?iso-2022-jp?B?ZjVvTjg2Z29STDVtT3pONDJnMWpSeG5DUUR0WTVsZGswWDhVbmV6OFpn?=
 =?iso-2022-jp?B?TG55c01nU0xZZlowTGR3Zk9JZ3l1S3V2ZjVwekg4ZlpwWnJEZ09OWExt?=
 =?iso-2022-jp?B?RVlvTkFkcC8yeHRYRHN3eFMrUkxtcnpRMnB6Z2JKTkc0YlNmYkdXdWhD?=
 =?iso-2022-jp?B?RXhONG9SVm5Fa3Z5WmxtV2Q1MVllK0JjTTRuSHl1S2NyTGR5Q05oTGt6?=
 =?iso-2022-jp?B?OUtwdGh6SHRaSWREb2tlQXFBN0RVUmtPZ1pGa1RSZ1gyMEdScys5L2hk?=
 =?iso-2022-jp?B?Y2RNcXlCQk9Xa3cyQ3Bic1RjaEliNmsyK04vUDlIWDRuNHIvMU5QZEM4?=
 =?iso-2022-jp?B?K1k2RUNvdWUrQkdoUUs3bThyUFNwdWlYZzNUZmF3bWczaTBjUkVSczU3?=
 =?iso-2022-jp?B?TnlST3V4dlVFL2ovUy9tOTZrOG8rb3FqeE0rRUtMd2ZuV2J4dVRxWjg0?=
 =?iso-2022-jp?B?dWZBTzEzMVcvNWFOTHVkTllLOHVHV3pCV0crVW5Xb2l5ak9JbCtwclpN?=
 =?iso-2022-jp?B?eVczTFVuQXBLWmR2ZDQ5WnljRlE5dDUvQmt6cVRKdmlnT2dmS055SFZl?=
 =?iso-2022-jp?B?YkhDMnduclFRVWhuQnY4UDk2dzZZRExKSjU4ZTZOTUtoaVRZTkt0aWVU?=
 =?iso-2022-jp?B?c3RacmRna0M3U096YWV6TWRrWWZSdXRRRlp6Y1VwSGlYVGdvUUp0c1pQ?=
 =?iso-2022-jp?B?aEsySTNpTmxhUFZmZGtXOVpRdDB6WlZDTUZwZlYvTDcxT0pQMU1EVGtI?=
 =?iso-2022-jp?B?UVVXOEdKZXIwYkxqdjNxbVlMMTJQb0hTMWxucCtWN0NTV0pRTFJPQUx1?=
 =?iso-2022-jp?B?YmlsdUdJd1VwUHVRYWFhcXFXaWdveGdNSWJic3VaV1NhY2NjREdOWnZ1?=
 =?iso-2022-jp?B?Sy91VUxpbUVBSEozL1JsNmpUekxZczhkYnFOTWMrYlhNMTNnYkRteCtZ?=
 =?iso-2022-jp?B?Tlh2UlFoVys0UFlSRSsxcU9qMHhtNDl2bUM2ZlBuZzlTa2FaL2VVc3dx?=
 =?iso-2022-jp?B?dDQvdlFMZVlkdjV3OEdCTlNJVE1GOTJtM1ZnVE9TZDBhZnJLZmRFZW5M?=
 =?iso-2022-jp?B?ZmxrSHFXd0JpNFBYTHNhRjJHZlZjNlFhS0k3T1hNR0FNM2FYSThGaCtv?=
 =?iso-2022-jp?B?VVFvMEp0Z0t6a1pzdWpBVklnV0NSSDNCNlE5aFF6b1A1YVZ5M1dBdHBC?=
 =?iso-2022-jp?B?bk1tUkdGeWg2UG92Sm9xcjVWNmtFaGZrUjNSV3B5cDQ5dVVhZEJYSW9L?=
 =?iso-2022-jp?B?U3JJRVpQMGM2WGpRdTlqVElMTVNoZElxTWd3L0tvTVcvTG00ZGZLZzNz?=
 =?iso-2022-jp?B?MzNYbXllcUJ0SEpLOTUzR3FKd1hnY2N4UW9KVGQ1c01JUk9FcTRuMHUx?=
 =?iso-2022-jp?B?akxjRDVtWHBnMUJBdUZqTVlQQ0NGZHpNUmcrUVgwVWRvd2JxTFM1blhK?=
 =?iso-2022-jp?B?Q1Yrb0YvT1phUythYW1nOU1qcWorSE5EZjJ3MWdEYWV4SU1TVm9uMFpD?=
 =?iso-2022-jp?B?R0xLbzJtblRWMEhrN1F5MTR4bDI5SjdPTkNCTTZKMEFYejYzUk5SdEhx?=
 =?iso-2022-jp?B?WTNPWk5jSWx2L0hpU1Nxcm8zLzB5SWhuT2tLM2crKzU0NnNiSk9semxP?=
 =?iso-2022-jp?B?RG5zSU9mYVQrZTlETitPbThGaUQ4U1QyeDI3OWdjMTcrQ3M1eWR6Y1ZD?=
 =?iso-2022-jp?B?SWZEWVNueGxpeVpmNUI5eXEzWlk2bzVyUTB5UFR5WDJsVVNnRTRYMFpN?=
 =?iso-2022-jp?B?Z2cyQ3ljaFQ0N3pNMVFSSjF5bzVreG1DdHBPWlBIeHZRZDRBb2FYdWNa?=
 =?iso-2022-jp?B?eVV6ZGFnQWRvVHB0NjIrY3VRSk55cUhNMG0xOHVvZlFMODVmUTlGT0Zj?=
 =?iso-2022-jp?B?ZjVCZ2RCaml0NExYc1Z5WER6eG9GU1Q5NDdnbEVMQjc1QmZkMGowV2ow?=
 =?iso-2022-jp?B?UjB2UDVLaG5sSmxKMWJwUjJYZ2hDbndINlNOTkorc2IyODROb1RodWQ2?=
 =?iso-2022-jp?B?RC9UcGcyazNrWTRselI2SG5oTjFxVXJQV1NKV1Q2U2E2Qys5akk1K0JD?=
 =?iso-2022-jp?B?S0F2NDA9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf63356-3ec1-4fec-e464-08d9dbf9e46e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 09:47:37.4823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SA7z7zchgQiiIgnps0FvA6lPCV2XmeLjlmitYyzdPn1kBkxPTcFWv7QajfNAsBMl/cZIdhUGG0SdPEDorio/2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2803
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

sudo ./kfdtest --gtest_filter=3DKFDSVM*
sudo ./kfdtest
Test results are pass.
Tested-by: Ruili Ji <ruili.ji@amd.com>

-----Original Message-----
From: Yang, Philip <Philip.Yang@amd.com>
Sent: 2022=1B$BG/=1B(B1=1B$B7n=1B(B20=1B$BF|=1B(B 0:23
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Ji, Ruili <Ruili.Ji@amd.com>;=
 Yang, Philip <Philip.Yang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: svm range restore work deadlock when proce=
ss exit

kfd_process_notifier_release flush svm_range_restore_work which calls svm_r=
ange_list_lock_and_flush_work to flush deferred_list work, but if deferred_=
list work mmput release the last user, it will call exit_mmap -> notifier_r=
elease, it is deadlock with below backtrace.

Move flush svm_range_restore_work to kfd_process_wq_release to avoid deadlo=
ck. Then svm_range_restore_work take task->mm ref to avoid mm is gone while=
 validating and mapping ranges to GPU.

Workqueue: events svm_range_deferred_list_work [amdgpu] Call Trace:
 wait_for_completion+0x94/0x100
 __flush_work+0x12a/0x1e0
 __cancel_work_timer+0x10e/0x190
 cancel_delayed_work_sync+0x13/0x20
 kfd_process_notifier_release+0x98/0x2a0 [amdgpu]
 __mmu_notifier_release+0x74/0x1f0
 exit_mmap+0x170/0x200
 mmput+0x5d/0x130
 svm_range_deferred_list_work+0x104/0x230 [amdgpu]
 process_one_work+0x220/0x3c0

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reported-by: Ruili Ji <ruili.ji@amd.com>
Tested-by: Ruili Ji <ruili.ji@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 15 +++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index d1145da5348f..74f162887d3b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1150,7 +1150,6 @@ static void kfd_process_notifier_release(struct mmu_n=
otifier *mn,

        cancel_delayed_work_sync(&p->eviction_work);
        cancel_delayed_work_sync(&p->restore_work);
-       cancel_delayed_work_sync(&p->svms.restore_work);

        mutex_lock(&p->mutex);

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 9ec195e1ef23..2d2cae05dbea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1643,13 +1643,14 @@ static void svm_range_restore_work(struct work_stru=
ct *work)

        pr_debug("restore svm ranges\n");

-       /* kfd_process_notifier_release destroys this worker thread. So dur=
ing
-        * the lifetime of this thread, kfd_process and mm will be valid.
-        */
        p =3D container_of(svms, struct kfd_process, svms);
-       mm =3D p->mm;
-       if (!mm)
+
+       /* Keep mm reference when svm_range_validate_and_map ranges */
+       mm =3D get_task_mm(p->lead_thread);
+       if (!mm) {
+               pr_debug("svms 0x%p process mm gone\n", svms);
                return;
+       }

        svm_range_list_lock_and_flush_work(svms, mm);
        mutex_lock(&svms->lock);
@@ -1703,6 +1704,7 @@ static void svm_range_restore_work(struct work_struct=
 *work)
 out_reschedule:
        mutex_unlock(&svms->lock);
        mmap_write_unlock(mm);
+       mmput(mm);

        /* If validation failed, reschedule another attempt */
        if (evicted_ranges) {
@@ -2837,6 +2839,8 @@ void svm_range_list_fini(struct kfd_process *p)

        pr_debug("pasid 0x%x svms 0x%p\n", p->pasid, &p->svms);

+       cancel_delayed_work_sync(&p->svms.restore_work);
+
        /* Ensure list work is finished before process is destroyed */
        flush_work(&p->svms.deferred_list_work);

@@ -2847,7 +2851,6 @@ void svm_range_list_fini(struct kfd_process *p)
        atomic_inc(&p->svms.drain_pagefaults);
        svm_range_drain_retry_fault(&p->svms);

-
        list_for_each_entry_safe(prange, next, &p->svms.list, list) {
                svm_range_unlink(prange);
                svm_range_remove_notifier(prange);
--
2.17.1

