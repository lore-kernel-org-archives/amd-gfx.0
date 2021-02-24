Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35352C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0623F64F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0623F64F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686826EB2C;
	Wed, 24 Feb 2021 22:19:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EAFA6E054
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHlC0VmYVPeZi01O0glnTvXlZAsNTRNG7fuKNP+cnRqYHcAktXKJdjCmfepuDvBsAQY7CLpxHkWp2GDmi2YJK6EPNIjqbUOMty61PsRgM8S8SVVShLHZVa2oM6gDbG9j2HJECKhC2OYSl77+xTFzKTbXHroEaCmKjHkkgbVsQPXtjGF0F1YgqbIKPENylKdJ0eTkm5PKCzU4de7Uy5MOvbaArPLGzN9WypfOZH7T/nIjwicJ16MRTuGvUlNeetM9AOUrRf9ek+fN3a4R9Qz8nmkEgXZVsVuIm5SL3fEMy03hVwpHPhlOMA/KQYkCJVZL7ahSu/5YTYp83RAfs2v6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqFDBa0HejjquMBEeQ/gO/SZDkOCjpGOxkmILNQ3glM=;
 b=Eg0dVjbUgbmSAqEcHjOYKuq2WYA5z4ZnO2+n7cZybffsN8zCA4jCALe9sagE5+GZjKZQnQpn24BeJcUlvq9xQsrLqK2SgMsRbFXeVEfzaJ47Qu3Tc1PPAgKKTT2ZhiPgcAbuZQ2xz6wdLqDPzFLsIexdsaStpG6Knkq+sA2sjkso3FGgPS3K8rLGuPiGcjB7o01pQqka2BXmywFCCED7/IEHx3oIRvOyENIBgd1lmXX/Q/AeHmEFmeVXQzLzKI/p6+l76pwbgLWA8EGzscUF4KkYbN597amwMA4vaATv8UpH9g0Iisv9U2pYgtT2UpkObvVplEElmtChcVeNdAW7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqFDBa0HejjquMBEeQ/gO/SZDkOCjpGOxkmILNQ3glM=;
 b=Z++meg4UABqkdnNydXURy3lBRFATg83iGqRD/XAxop2YzAawV7cAiFw5Et5OUW/RUx5WTi5Tkn2oxiIRMh2n+GFN1VYB3fNlhPhKu/LrUhuhnpKqhw1eWaXckP3pLYAw3t+9lr1sktzvBkD4xXotjEBM437DHG/MPti+6+K6WzU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:19:44 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:44 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 036/159] drm/amdgpu: add new smuio callbacks for aldebaran
Date: Wed, 24 Feb 2021 17:16:56 -0500
Message-Id: <20210224221859.3068810-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2456a2ee-1735-4ab3-2d7f-08d8d91249c2
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB48655DA8572CCA313290FFCAF79F9@BL0PR12MB4865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fu2y0PLXVyvz0geDhfA5m//TeRH/fRhhPHim8FdpoFOXtjK2q5uR6iBANISL4gvADea1NQ/oGh0HYc1LNqhDENhppuz7QWj406O4pq1fsyQYtCWM2WQXre204883E0S19nY80oDs7/JTla3XCELt1pG1cRq0yxVnl3QXEtIyG3szzC0Jn86ycWNDIQpLi3xdYxFlpIdQCeJQf285LDv3sFTTNWVQQL+666SDDLOA9L0VUcUhFzyEuR9n8yaq233RkJJaBsAIlUk3L933CNdsXlQTtsv8e/uGQQYrxW/SiTbdEjHpJWOJIK7pZVv2B9ESFCyabJ0LzS9j0B0as5LUP/4Cl91ACLqXzP6QkztSo5PZzcCL0qOo2KjM1bz4MkLq6P6t9idTM/+9ZdpxWaFR3gqOwbmyXEWs7Oeu08DwtAY5WfQ/IxNaX+uqxUB+BOOu+kl0RI36BOPzmCvvBtMX+jtLm5J9qUFOGQFB5vnl1ivfuZbABr4T27Oj2sJNG4jE5VT0veWDo19fB8hNAv++RQ87ichSR0L3PsDcaK5pDIw+3rwnBOoHm+KZlTHZ70ps
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(6506007)(478600001)(316002)(66476007)(66556008)(86362001)(2616005)(5660300002)(6916009)(8676002)(956004)(36756003)(1076003)(2906002)(6486002)(6512007)(26005)(4326008)(52116002)(186003)(66946007)(69590400012)(54906003)(8936002)(16526019)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6z6zADI3UGC3V62jxoS2kSYAh4GGCSqZDld+hJbirMf6MqCHPyu20dxEQqMa?=
 =?us-ascii?Q?2KnWwTQ5JOezeVQBXA8zAwqbbH+indu/gYPe355Flwb9JsZ2Lolg5ku3bm7B?=
 =?us-ascii?Q?pzlNWEn/LZSSMSx28JfgmaKtXNJeFwpeYj6+pgQ7cc7XJqB6RIOdgWLge5fM?=
 =?us-ascii?Q?2WmrTa5Iu9ow2nKHwVohD8AHt6Bb5R2s7VQsYEh1R7sG8HOWtzamagBOlTRK?=
 =?us-ascii?Q?POEi/g8lfj+uFEJDw7ggN5rz/oeu7BJbixo4uIi+LnUGUqnI3O4MlE9Muqt+?=
 =?us-ascii?Q?mIJtleGzmGK3wKlPMDoFJeA3UktiWKdL5vmfs0ScgwfaKkglXjLr7WXBZ0kw?=
 =?us-ascii?Q?k/GgDIrDaG5jkkZ1gB5wdCJoPO4EocscVp2JMrZfWXlO0L//7c5gKfIpYkmA?=
 =?us-ascii?Q?miGJr0wkEXYZY3djk/mJFNsPZukTGAIYh5KCIgXU/A7zrmCEfQ1296+0pKY0?=
 =?us-ascii?Q?p3YEBZ71tUoEYS1sC5Wngc7VEvOHqkBSpbebFpdLmPBuOuF0PjNoX8pmRf2R?=
 =?us-ascii?Q?a0Q/R6eAJkr3MIDLiOkn8z1Abk7TQ7jpAnwFpFFoGmParSwQVKc1g0WvpVZe?=
 =?us-ascii?Q?xj+VlC0/x8TlaYr62udSr0tU3VWe/gs2keegRHwX0NPqF0PNwnpKKfKOYDcN?=
 =?us-ascii?Q?WvOZRXNGaTDyelNA0uB385TfuNWL9o7hksTebyjfnHI39f/1/vsiz6kXMQWC?=
 =?us-ascii?Q?+dWsmZ+mbityJtFSxAa7+gL0JA6VNK2xhd3dc2R+FD0nrd+A+0yVfmCkyW7D?=
 =?us-ascii?Q?n97dgD/pWmY8IJ3KXgsR+iO9WaZ72DIdkiea+UoDhjHBvb/MURxQii0k1tI0?=
 =?us-ascii?Q?URyJdTk6Nz0kUXqkuaPazII0B+pQ6dgADEvmgjT7N3ouO7r1wgEBjRxc4ubu?=
 =?us-ascii?Q?n30z3kzLJL99inF+A8KfqALqxuSPxv2vY6SuEfEUdWzwgv/WZoFo1cV8gWnS?=
 =?us-ascii?Q?u6xIs4+HZDxN2n2cMtVGnHdNxX2C2OhbZzVZNuRs7jEAVXDFUJZ81CixkQFD?=
 =?us-ascii?Q?DfZY8CHdk8rX5RpZ8ObZqIcik0xsEr0UcUGMjeslAIzMRoUNhif+7bxPNnwL?=
 =?us-ascii?Q?P5Xm9YSyba88etx8TQTfaiBeaL0dtkrH79jGut8fUiukfwiFpONCxe+oGDrg?=
 =?us-ascii?Q?znCEC1y4ttG7ntT4dlq+r0hyqCIclhEK0h3TQ8j7z0RbRraad+lbO8gnCsY3?=
 =?us-ascii?Q?UpUCoDD3aiRoc2lbmTHUaQQTzf0asqbcSKjcVwqXXd5Df43LyaUUngsTNdrn?=
 =?us-ascii?Q?7wLY1uaZvP5z6RbbrsXUzeQb7hH0GNsBPDdKwm2EvTZdKtGdVo645SWRxbjA?=
 =?us-ascii?Q?7tqGhNTDgo5MgGYEkSTe/+eG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2456a2ee-1735-4ab3-2d7f-08d8d91249c2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:44.6700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xIgqlY1ZTLoVZBpWEysh5r9ZCZCcMIV+iGLqMtOW7opXaNr/6CABTFNJqsJ2oDmg5oDoaX44r0EBQG+/SuQtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

is_host_gpu_xgmi_supported is used to query gpu and
cpu/host link type. get_die_id is used to query die
ids.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
index 03009157aec8..b860ec913ac5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
@@ -28,6 +28,8 @@ struct amdgpu_smuio_funcs {
 	u32 (*get_rom_data_offset)(struct amdgpu_device *adev);
 	void (*update_rom_clock_gating)(struct amdgpu_device *adev, bool enable);
 	void (*get_clock_gating_state)(struct amdgpu_device *adev, u32 *flags);
+	u32 (*get_die_id)(struct amdgpu_device *adev);
+	bool (*is_host_gpu_xgmi_supported)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_smuio {
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
