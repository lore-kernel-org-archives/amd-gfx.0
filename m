Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B7BC282C5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 06:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F015210E039;
	Fri, 28 Feb 2025 06:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DYMO2Utl";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1BC110E1B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 06:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8vgUrezxn8ppWhbLJwvaA6ptnC5OW80B6vkIzkiZjHXujldfBr/H6H5KL/tMzZedjx/sGS0BTkpKKH2zO8Rz1i+E0ixFijDE/4cTEBXwknLXKpvB6wkPgzMjKgCg85cOc/bfhkNprNyzprZ4WJdameqkZuT5crhUOmyE8PPYnCkT0Qbw/Oz+HibDlObhUP6qHIlSJsAXHXOXMjL5UAZXC0Uok1FMogym0UnPGnnK3Z33uv8OJ6vMgsbxww7INfKGILnue9HKqzcwqGRa8fFA4QRjUVh3WVJkHT61xI5FZKPd/c/+OpQOmSPSRoxOAOXmCv4QmZDaKWl+wd/BNspjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZFQ33khjnAq3YqzQywAF0f6UWC+TrScYIZxzHrkIVE=;
 b=zQSVZjEcThi5SSAp1FVU8BngK6uZhh+bbB7P+ohrujcUw+7Tx8n3LymyLZJUNIneKQHXU0QGKGo/5MKdACSBkkwSwSGuU38cr2Bn6qS+TqcgMRXzqmCduPnq9qi8Y5yTD2+kZTv1jkd76pxrgnsD4vKkgBSpOeceJC2X+b3pXCkhdSPMP0COKu2w3q2TP8COjYV7dGXHiFmx6xu+pTdInmyNp2PvjYMscRSnwd7DSszb8wKoC8do1oI9RRWSHqnJl3ZVg/27DQRVXNukSbYbQ3ZfIF7zW0S6WBLKFzuwzi0hDW8CBTSK9Fa4rwgGHA1YjrMwQVhUmFyHWVMaAHT1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZFQ33khjnAq3YqzQywAF0f6UWC+TrScYIZxzHrkIVE=;
 b=DYMO2Utl6enijEzj2w2zhKXp/GjiR16RgpXrmZPBNRDRWEN/FrynZ/7dtpYpLcCIKPkpJsDQuxH48GXyPhsDINqAKrtpZ0pppHSwUHDC1Wcc5fm5W9MXCTfugFBcRgOKb9yBr/xH5xY0gwdY6ZVwlocTR52KOFBuCK2f0BrtGSc=
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by LV2PR12MB6013.namprd12.prod.outlook.com (2603:10b6:408:171::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 06:25:12 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%3]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 06:25:12 +0000
From: "Zhu, Lingshan" <Lingshan.Zhu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdkfd: initialize svm lists at where they are defined
Thread-Topic: [PATCH] amdkfd: initialize svm lists at where they are defined
Thread-Index: AQHbhEJfUGo6gmhlr06dmO7TjjtM8rNcSktA
Date: Fri, 28 Feb 2025 06:25:11 +0000
Message-ID: <SN7PR12MB7835BC07E71E4B573B31C7EA8CCC2@SN7PR12MB7835.namprd12.prod.outlook.com>
References: <20250221092355.336312-1-lingshan.zhu@amd.com>
In-Reply-To: <20250221092355.336312-1-lingshan.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=21a97b8a-0399-4d31-b84b-953bce66ceba;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-28T06:25:08Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7835:EE_|LV2PR12MB6013:EE_
x-ms-office365-filtering-correlation-id: 972b5642-f6bc-4577-42b1-08dd57c0a7fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?o4KKAajzuaiy97g/zvdEn4eFjTbrM0ZVqjcBOvz1EtQJUXJNUIGGbEZnD5fg?=
 =?us-ascii?Q?8iys9FyPRbmCahHsBW7i3HFb9Rp+4X+sq2amsXgYXJzywO1tlx312BgVoDf2?=
 =?us-ascii?Q?CcKeXZizkzIiFlXrJfDwVTGhyA7JmDG8NUg+CQQ2knF4wKJgVGSWAWJ5TwvV?=
 =?us-ascii?Q?DNcAyErJ3wiLHGcV4f0XaSmcbj1hSMnr2mWi7QTXBXP1/yDHaKUefJjY1rE5?=
 =?us-ascii?Q?3LP14CeBZv1BeFdz+sXk8Od/FEZy+ApIZkcEhZkJAWsc4Z2KAc4JNjetBdaD?=
 =?us-ascii?Q?CKfXL3JFFSuBkf45PWDdwSPClUlhoiXfgC0hqT/8EPTwrfWCjBGJ6iKcNFrE?=
 =?us-ascii?Q?RoXFFylQOpQGlV+2xhLxtv4d8mHuAcrxBPaEK30Bk/GxYC9pfEXjleul8KDV?=
 =?us-ascii?Q?XgMRbpTAjMUMaTWraNJ05NsuOuYirGm5q4eMK/+y/Q1rf6Vd4dxxwb+nsLai?=
 =?us-ascii?Q?9iAQB8dUobjOfXI4CDHYJolOK0/BErqZ/Ji3kF1VDl9CmBvubTUVN7uvBrmI?=
 =?us-ascii?Q?gMswAnf0tsVxadIYhNYmotQk6T8b7TjSIVvPQLJePis8ZNXhdwfap31fODc3?=
 =?us-ascii?Q?qbkKWXM4x2WvYgT4WqCNz3lYPL8WrQjam5Vr6uc1oPds9ZDKknlFddcdNLkD?=
 =?us-ascii?Q?/ONxzeu9cRAZrZ7LAU4q3qqpQRMgpxYMcGWVot5mjhIS7MCJDsrsHB6OJsaJ?=
 =?us-ascii?Q?uILeZS9yqeEpTGJYqKhZKBMm5HjIlpkSrWfaETL5PmVVaUMxKQK0d8X0ZfJw?=
 =?us-ascii?Q?B7y8/UrtJcnwybuae/OIceB8+NnORdkx47il073tj2+oO+32F2nd7z+Saqxv?=
 =?us-ascii?Q?eGJE9xZ4JcoBQB82orBtrZhwrR0Rf+CVKds2G7Dme+TpU/XG7Yd//KkN0IbG?=
 =?us-ascii?Q?3Y0vfqh0YfP+E8lpHcF7lHsGGfDeW2Jbjwg9ofTbQLlLgcZd2VRDevXk5LOC?=
 =?us-ascii?Q?0evTFzjjqlH13YI8ocjtFl3tju8xW24HfNjB7VFOZLx2mA1gLKZ7SOI+Tpjv?=
 =?us-ascii?Q?T28uj08W50Dcelqc7rAA+dS2t+DuRI8ONQqSTmvoRKgyHPYZpIneWC30gUM4?=
 =?us-ascii?Q?+U27ouNk0yDIxk7mi22ZrswKkjHmgQB/4R+J4Lk/vHYcV+K6wveaVORJNOu7?=
 =?us-ascii?Q?und+Z2l4P39he6aOLvraelalCy/Uro4yXcr6Ppkz0g2PezJhqtFLVwq/Vm6Q?=
 =?us-ascii?Q?OpnCUnpvwfJALgPvS7vBBip0znXy2EL9L1FU6sqF5usFWleJFzooqsgY8y+g?=
 =?us-ascii?Q?GdEwhXvqb+LqQPxQ1DWqImLbAMZCZ/23LdiSuwIz2sNxCz+Dut/jMxYqN2Ib?=
 =?us-ascii?Q?gKDtELHAfSbtiByHvS6hGf5xAEgpra6N0tWbyLc/uUmAfUw0PwJCaXB4IWdG?=
 =?us-ascii?Q?maZP2gRUO6Jph2Da6WwOMhiE/sA5yNDXJtofUlw2AbWnge+NQGMhUMfd4rhi?=
 =?us-ascii?Q?VEmuyiaQjdlcb2JYRoIDmd/FDdTM1zJA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?irSk3UUMgDkgq4cjipgqdV/8NuIC7XpAlxnjOf/awaZdlPskTsv88a2hJeqB?=
 =?us-ascii?Q?lMEKoyUMxRJ0OG7HNB0Ifxf3FeJfKv4AOc1NVbZGlfaTN51VO1MU7wOPZTJg?=
 =?us-ascii?Q?rHvbF/+H0B5hZb97SDapwWrWWcHa9BbXptb9BUOqt42lDAPmeySF0rr8Oz+J?=
 =?us-ascii?Q?8UfBdGaG+U7Dsk2MZtea2bcf50Xz7QgJv7QlrlKzJ2MJ8IDsn50goiCARd81?=
 =?us-ascii?Q?BARJrZxOfNSnG7c/NQzYlW2lMrFYppm3KXN/W/ZW3UiHKVdU6k5WYiCxv5+1?=
 =?us-ascii?Q?S9EFQMCoOCcdP4R6ToxRsW5rJk5RN3GflxXZ9Bc7UBjKRkWyRy8QzYaMoIDx?=
 =?us-ascii?Q?60KulVF8c0nNfnLql421vSVSg42Q9I6QdNew3A0srJPIt2OWUX7fjGnshGRj?=
 =?us-ascii?Q?Fn/3J8M8JJnDliCVJX77crkRPEnf3uFwB/DXeS+fTaPoRCw8WljhvN6p3L92?=
 =?us-ascii?Q?Yy9WsasU18xDFbNdmn60Zg6rjXadBlHalpn8tLiHWAAbZGm0KlGSkXzW7hgd?=
 =?us-ascii?Q?QHrv3O4Sbru2dKf6DQSV6XHPqRaLChMOhnBKM0r5ZDAsUvembaPmPnQxTi52?=
 =?us-ascii?Q?sVsnmFIAFObxEhS/bPUA7gZH1Y+1HjeXjHMaN6JgnCwYnrZigUby7Socbf0H?=
 =?us-ascii?Q?RNK1zIH1Q4sJ+cB7dKZEnRoizCo4dbPq57BvYoCUxdT004WXiIkYQHTdg7uQ?=
 =?us-ascii?Q?YCDbYsd5JmJ7+q7/TTwsTAyE9TnnjB09JyTfxHDdI1+GC3PAQOpx24vLDwkI?=
 =?us-ascii?Q?JYc2Gs+TRk+UIZnFHCiinN3fbny5PTikSfvxcrHyLA7qc4ZeL7jOMXksmWP3?=
 =?us-ascii?Q?xzaUmO9MuH8rfhGTEUpUB1y6dfrV2lGpdJyCqbcTM5bVZ95WR7VFHpB/+9nj?=
 =?us-ascii?Q?8iMwCX29DbCLjLj7MHkG7XyXaO3Qe164tFaSsw22rb4KlOuIWYOvpTxGQOCL?=
 =?us-ascii?Q?4Ueny0AhzH3CI8cEAKkG4htiiSXE9c7u/c7YEAHvTde0DFRi1q6CR3aZ5rhK?=
 =?us-ascii?Q?LFhlMCZmXnMvC/HW4hHl7czCH5K+AdNQfc24OQC7E3+NPeYdULPGijdVtnxj?=
 =?us-ascii?Q?sBfgsSbBKxymuupqRbceK6xf0OQfbcWfNy7sN4AdK0xh2blISMdesdAj7Spb?=
 =?us-ascii?Q?yG4qdSc3w5VTKXqeblGIl4M/SmeSDuf3199C8mSYxHTO52uumtIBUYQ3Gjtg?=
 =?us-ascii?Q?YrNw2hNL8lVLZWhHxO/yj/ucYrwNNMEsw+rokBwzeqpkW0YKjJBf1uMuGbiA?=
 =?us-ascii?Q?YZKM6+u6ApXlDeuXm8D5xErtikzUEF4Ai8/lZ40EZRbjcyAICrme5/VbGHyQ?=
 =?us-ascii?Q?xrr6UkAaZ4tH+vSSmEGYV53JbOSUiN0DxDGY2+I7aVaTU1sskzUG4i3e6Q3A?=
 =?us-ascii?Q?XBMstVYgIviXJUYuIHcN9FUkzakJd+/dx2Feciy0XPPicHph+BT8G8zlkH8U?=
 =?us-ascii?Q?C8NvnDKIvL0vk0aoPhR52TCO0DO0bke123JJahUEkab7oPISTJmao9nwy4hU?=
 =?us-ascii?Q?JfbNRQTt0CvWik3D+YepNbBW1CMUsLq333qSb+o8bnzF3M/apbIJlkSH/xlx?=
 =?us-ascii?Q?kWaeCvjFdQmkODDTQG8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972b5642-f6bc-4577-42b1-08dd57c0a7fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 06:25:11.9817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymRwdcdQMsiIqSQd+WFYiLJR5wOrm9XLWteuezptdeTuYqk3p6zk3o/1QG4AbafMgp0jBQK04iRTw9T5TVC0Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013
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

[Public]

Ping

-----Original Message-----
From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
Sent: Friday, February 21, 2025 5:24 PM
To: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>
Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org; Zhu, Lin=
gshan <Lingshan.Zhu@amd.com>
Subject: [PATCH] amdkfd: initialize svm lists at where they are defined

This commit initialized svm lists at where they are defined. This is defens=
ive programing for security and consistency.

Initalizing variables ensures that their states are always valid, avoiding =
issues caused by uninitialized variables that could lead to unpredictable b=
ehaviros.

And we should not assume the callee would always initialize them

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index bd3e20d981e0..cbc997449379 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2130,11 +2130,7 @@ svm_range_add(struct kfd_process *p, uint64_t start,=
 uint64_t size,

        pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);

-       INIT_LIST_HEAD(update_list);
-       INIT_LIST_HEAD(insert_list);
-       INIT_LIST_HEAD(remove_list);
        INIT_LIST_HEAD(&new_list);
-       INIT_LIST_HEAD(remap_list);

        node =3D interval_tree_iter_first(&svms->objects, start, last);
        while (node) {
@@ -3635,6 +3631,11 @@ svm_range_set_attr(struct kfd_process *p, struct mm_=
struct *mm,
        if (r)
                return r;

+       INIT_LIST_HEAD(&update_list);
+       INIT_LIST_HEAD(&insert_list);
+       INIT_LIST_HEAD(&remove_list);
+       INIT_LIST_HEAD(&remap_list);
+
        svms =3D &p->svms;

        mutex_lock(&process_info->lock);
--
2.47.1

