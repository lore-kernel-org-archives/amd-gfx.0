Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E83FC61DC2
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 07:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E721010EC16;
	Wed, 26 Aug 2026 07:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A/jHUHoA";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011008.outbound.protection.outlook.com
 [40.93.194.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5283A10EC16
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 07:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuMHSAC8WpLWRyrYJMW5WpZqdvi8aN17BFJDjsqywW6dyhK3YG/QwS//uIYNIHwgHQNAX67pCu1Wg9TFDbgt5s/QJ12Tm9XLPEaRMfUG7Q8HoC/3EXhNs363wSq5PN/27W/kUD5pwuX+MQYe30HqYWYOCC0TYSgwlVvbvC0SpEgQyGl3fBHVtQx/RPlEaX4IUSM01EzaImY1eyvX6oM+7wud/FCHfybFAAeuRsk7MjatabfelAvCUHDK+BV9e2psKV4H3alJ/gIw9FxHqoFzH6DUOlNhiNp4L2ulZ/hiH0UIqkt7OonwtoYUWC/DCGbqdv0W/Ld9uf+ulERvn5Jk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pdqd6h1yxJ4lMGA4eH81whKYHSbsSoP4Wo5je1ZOHk=;
 b=BqcyHVsMi9G/CHfkuQXBvGBxwuQAFx0N1Q7asB1/7SipepFQawb1AKsr9o8JrgiPoOscMBqUBLkwwvOj83H+4D3/xcB4sDttKdEdcg6iTBx+eQfQ5nD/aLvLTSlygyukKJt9niXPb0mljSD1IpT/RYwZFea9Ug/dvlvwpjqjeO52cz8cFb+rYxqT8ssJWmbLOIjn0wmMAgiQWSB+oCOQ/6fuHaWVggtSdHM43MeDxKB9uVbsYYXM6z7NAskFog1C/rPlSuDzV+OAVPWtX1A8+t4+TxuYY2zLC6/OM7M+GHuDXZ0NKFSf0GtXArKnLzf25Hkr8y7TIQoCExN3T1nkmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pdqd6h1yxJ4lMGA4eH81whKYHSbsSoP4Wo5je1ZOHk=;
 b=A/jHUHoAPWz0WEe235eRgFT5bSYN4uP1bCMni7kXuy9jWxerhW2agoEvhf9euU+Zjc1m9eTkW3E4O/xUkJHEklXE9LRt02IwjnrC/j7cCcJJ3t4Helidy1yK0oChgGCYmUs+ZMVzhFUWkHpFgs8xCt3XUqN23CkRP7IoqapeUEU=
Received: from PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 07:40:46 +0000
Received: from PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::17d6:3ce4:21e6:8c8d]) by PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::17d6:3ce4:21e6:8c8d%7]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 07:40:45 +0000
From: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "YuanShang Mao (River)" <YuanShang.Mao@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: mark queues as reset after a full GPU reset
Thread-Topic: [PATCH] drm/amdkfd: mark queues as reset after a full GPU reset
Thread-Index: AQHdMJJ6sAp4+FJoG0WIyvpypN/0+rasxHgwgAM2LsA=
Date: Wed, 26 Aug 2026 07:40:45 +0000
Message-ID: <PH0PR12MB5420B7C44B32D3DCFED7FCDAE0AE2@PH0PR12MB5420.namprd12.prod.outlook.com>
References: <20260820105537.3138777-1-YuanShang.Mao@amd.com>
 <PH0PR12MB5420452B1526CEBBF8EFF704E0A02@PH0PR12MB5420.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5420452B1526CEBBF8EFF704E0A02@PH0PR12MB5420.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com,Lijo.Lazar@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-24T06:35:51.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5420:EE_|SN7PR12MB7450:EE_
x-ms-office365-filtering-correlation-id: 856a3b85-e3c3-42e0-4212-08df03455704
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|4143699003|56012099006|6133799003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: lGLWOKUdpFrDlqIzpWIpubdqBjTKhi3DLVAninja5P5RPrWnUu9F9jE1POsjPVH4bpc8IsFHcK4V86f5+fXWzP71XGEs9CR4EOD4tfzbtndfsNzOiC4OnvkrcDS3zG6i72qnynOZTne/dTK6EGRXhUL5vC0PCJCh5w7gWJTsdQjvsNx8bN41qrKeWcPfiAbxMs7srbe+ZMZNEFvTsFTosJinpSxThTzoeyLv1aStLaAr7wRjrKAOuNGk7iqkU/SYOB9YzYU9URSS8gKnWOjH3nkfi2IubhCUHYnZbXgTqioO3RnwXiG63QzUZDm2cvFP4pgjAr/i8NO6ZmQLKxEmTarO/4Wr0rVTpAZP3er8do3Ktm3e4cPtRmP77Ct5PWcdk8qxkGaF+vkcQ8oR+LYiYh7l6BvCd7igHP+DS+/lk79FvM3jteBkkGrMjqRTSVYCNEnfvqTIPg34dJvAIqE1lRndgqJT2M+3QVZ2EE3AKQ2nQa+Ia4ilGtvwrihOybDG7/XFfYvhMjlqtTFsD04WhZSQ9fliv6HZlr/sMIILW1CVUmflrcBZFwsy0sXfC/AhpENWXscZzYVRxGFGRMRS+1Si3Jt2Fyh88lsIRktEXq4pr9TEbrGkn3ltIkAg8mhCtEFChYSjkjomu5w06K6+cisMI6FWBXGMtkI+Dsm0iulU21HLocd2uIq9KGH3DRZ2O3MItWEe3093T7j4X25+AKTzgq+An2UkYstMcfnmzkk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(4143699003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vmbngmBlAZtxd9N7lAJfZFGRkocd9S3E9lBpBVJLotHPJjYni9ya0WaeAUg/?=
 =?us-ascii?Q?xHUInPLutOD2s+iDRGtY79XwAOaFFtnYErvb0KTX877ZC9ZnaPVgRz0dwNaB?=
 =?us-ascii?Q?zQvSht5DB1PHzjbBzUGw2oes5u3+deVGaNwXIKM4FHIgVhzYhD+1QVO0hQ4N?=
 =?us-ascii?Q?FUdgTi4e4/BmEm4c82ltFOjEg278uO8RsOgPInXsS+6g8zbu4mZnk5dMvZJf?=
 =?us-ascii?Q?Lv7Wsje3TvsbeGNPb+ZyCT8BBkMGFD5c90ED4JMZescOoel/+g9QQYooYChR?=
 =?us-ascii?Q?7zH8xPUBWK3T3ck2Jg+966C1XxircQnTJSi2RexfcEjzFYifEOylKQJfXD2c?=
 =?us-ascii?Q?fvdqaTMhbpbcbJ9qS+AxjQ4HT4ofzGhh/nUgHdhfBizLK2rkncmtYSetTYSu?=
 =?us-ascii?Q?yTfzUNq56T5t9e79bh6KRtA/12gOAnMFjApTW9WD6lq8l2+bNrfjF0h0vhCi?=
 =?us-ascii?Q?vWt63rh2a6LZ6LQXODy1RFQHfidPXOLateE+x6cKLO6rZza2RPiFUhkNfcq0?=
 =?us-ascii?Q?wGQ8XCRidSqR3yMajrkuaRj952g8vMTofXUX7eUskeClmd0ZuCQ7kUudPw0D?=
 =?us-ascii?Q?2rcnf0fsa/PPuLJIdBxB70+5N3YIiYPnmny3/SXz8pMTwq3xzAyGTsXBBeN/?=
 =?us-ascii?Q?sT+POvp2kktjaxlx7x4cLpf7w5OJcBP/DOB/BGh1qCom0YWmkVNWFOjeX3xm?=
 =?us-ascii?Q?SXv7Gy6gHLH7f89BWV74+Bmu2hkHfrc7JE/q5ChyXVe/wdLqYFwCHW8bOMHR?=
 =?us-ascii?Q?mJNt4vRThDQK6YbMP775mXApgL081G6mtlv4tuQhSULqHKNRdjK3bEq+pJTF?=
 =?us-ascii?Q?wCm7BvWd1mZeKWCM21OZuxsZYmzZ9zeeLWAmOqoTP9XLiHnKENQceTBvysQN?=
 =?us-ascii?Q?nrX5t7BG7FJeaJL6Gya44+wk8kiqB5odpZl4ntct+wvNIjG43JioYy0qtoYz?=
 =?us-ascii?Q?ew78dD4c87IAZUnyY51wSY9iul9xsHNT9HsmoKKb26zS9A8VcTg8zCH7N/AS?=
 =?us-ascii?Q?lW+OGnw7o9UmCYepwBq5AAHphZuImRSVVVSWLlLsCNDIp8SC7gyGuikHyddu?=
 =?us-ascii?Q?hzgw1o0SghjoJTA+ycXaqFSHrqh0q6Upjy5ea78kgjMZ0yZCD0jvG6puL75T?=
 =?us-ascii?Q?qPpcM7lZPQld3S7XC3KIZ4u2NF6YUN3dXFvzLEMeK861ntB19ve4CEQNS1OO?=
 =?us-ascii?Q?RVTH8KWdL80kt/pEJO/SmQ1L2NaGW4SwtPC0Ji078MP+qquwsLEKpjdlMVdV?=
 =?us-ascii?Q?v6pfoQWIYJ2uobrxIsYCC1QfRPmHMBNfEUzN4pgO0DLGWUi09gE2rakhoGCB?=
 =?us-ascii?Q?gqLYVYJ8ZrRIlpP2uTm+kA554S2rJuFtFndUKoKTVDL0gIYCp12+9cPX+tIq?=
 =?us-ascii?Q?lI5xnfXGB39OuT0DRR0JdIYuoOScUQSJftq06zI8LHiZeIIcwX9G7rD0P+Lv?=
 =?us-ascii?Q?dNKciNpuhehtRjXvlJsW0kEsrpa6AfT8MivBBZG1N77ntmTFIunE2fN2gLx/?=
 =?us-ascii?Q?7gSicTsMOYve1BVztXqitUXjUl0415ZrDRKqsHeUxUMET8t3kLN7rV5rsRuO?=
 =?us-ascii?Q?t7Ur9UEuNH3lgnKeNm6GTYEX09LZIgKflSIviukWqp/m6P/Vw5PSUADEKoS3?=
 =?us-ascii?Q?I3WztI/xmHiu4iqEBLRclLUqLMR4RBfmscbHVOTnE4fgWeBHExnMqrITl7QA?=
 =?us-ascii?Q?J1rQ7USmfDvRXLEgDRQHumeQMuZUknqQK+QZKWFuUGEv5x5T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856a3b85-e3c3-42e0-4212-08df03455704
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 07:40:45.6983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nsbVms6+Z8g1JUDme7EIzlqG6A+V/hSPnPziLnT5bTxiNPvXP0tbQW4xVs6Uvp1Y7RmB5zQAqdRIFGynlEbKIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450
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

@Deucher, Alexander @Lazar, Lijo

Could you help review this patch?

Thanks
River


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YuanShan=
g Mao (River)
Sent: Monday, August 24, 2026 2:40 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Tiantian (Celine) <Tiantian.Zhang@amd.com>; amd-gfx@lists.freede=
sktop.org
Subject: RE: [PATCH] drm/amdkfd: mark queues as reset after a full GPU rese=
t

AMD General

@Deucher, Alexander Could you help review this patch?

Thanks
River

-----Original Message-----
From: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Sent: Thursday, August 20, 2026 6:56 PM
To: amd-gfx@lists.freedesktop.org
Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Subject: [PATCH] drm/amdkfd: mark queues as reset after a full GPU reset

From: Yuansheng Mao <yuansmao@amd.com>

A full GPU reset reloads the MES firmware and wipes its queue table, but KF=
D keeps the queue objects with is_reset left false.
Pre-reset cleanup cannot fix this: it runs with the reset domain write lock=
 held, so remove_queue_mes() fails with -EIO and the cleanup loops bail out=
 early.

When the process later exits, process_termination_cpsch() sends REMOVE_QUEU=
E for doorbells MES no longer knows about. MES rejects them, remove_queue_m=
es_on_reset_option() mistakes the rejection for a hung queue and ends up in=
 kfd_hws_hang(), requesting another GPU reset. On SR-IOV that resets the wh=
ole card, so one injected hang costs two resets and disturbs the other VFs.

Observed on Navi32 SR-IOV with a compute workload running:

  ring sdma1 timeout, signaled seq=3D239, emitted seq=3D240
  GPU reset begin!. Source:  1
  Failed to evict queue 2
  GPU reset(1) succeeded!
  [ ~34s later, when the killed process is reaped ]
  failed to remove queue from MES, doorbell=3D0x1002
  MES might be in unrecoverable state, issue a GPU reset
  GPU reset begin!. Source:  3

remove_queue_mes_on_reset_option() already skips queues with is_reset set, =
but only the per-queue reset paths ever set it. Set it in kgd2kfd_post_rese=
t() as well. Suspend/resume is unaffected:
it goes through kgd2kfd_resume(), where queues are re-added to MES.

Signed-off-by: Yuansheng Mao <yuansmao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index 586e640f13dc..d326e41a8656 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1033,6 +1033,27 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
        if (!kfd->init_complete)
                return 0;

+       /*
+        * The reset wiped the MES queue table. Mark the queues as reset so
+        * that teardown does not try to remove them from MES again.
+        */
+       if (kfd->shared_resources.enable_mes) {
+               for (i =3D 0; i < kfd->num_nodes; i++) {
+                       struct device_queue_manager *dqm =3D kfd->nodes[i]-=
>dqm;
+                       struct device_process_node *cur;
+                       struct qcm_process_device *qpd;
+                       struct queue *q;
+
+                       dqm_lock(dqm);
+                       list_for_each_entry(cur, &dqm->queues, list) {
+                               qpd =3D cur->qpd;
+                               list_for_each_entry(q, &qpd->queues_list, l=
ist)
+                                       q->properties.is_reset =3D true;
+                       }
+                       dqm_unlock(dqm);
+               }
+       }
+
        for (i =3D 0; i < kfd->num_nodes; i++) {
                ret =3D kfd_resume(kfd->nodes[i]);
                if (ret)
--
2.25.1

