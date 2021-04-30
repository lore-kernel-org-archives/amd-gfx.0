Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54527C43461
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 13:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47D361418
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 13:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47D361418
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E5326F523;
	Fri, 30 Apr 2021 13:33:53 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EFB86F523
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 13:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgV0AIoPkj9Tu9yACpAos5QqzGR24pllXekWiTiTwn2e3+kR8nk8SB7XLAGs5+06s2hO7Vjf7N9Ic9Ov97EuOXDZH+B/9XWqgHKZiZWzkEF+5yYbd/Ov6Un4dA5NHARE5exDun3V5PvxC85g+CXnemqD5LrXEfALLcVse8xzZuRK5fpncqmhB3fHdrSvh7zvCgkMAkHU0ldiybD+z3DnZhiA9N8mtusbVDFgMADCObuPYy6qJMSfoM2crgFKNYEyxx5AQSyQWbPua5505yTBMW34/yotW+c8PsP21ymNJ1Xu2eiB/XRMkdbOk34F5RJVDV09ZfqgO5wfFCG2dgYoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct95U4tsKfdbK9z+Wg2tgFcS6i3+DRGQn1NrtD0g9X4=;
 b=mt+B26dZ3yBMu7SJDzThCZLpRjfnN3MvB2CTAb0U/EO8QnMfo3GIvliqQVpOfobuf8hrKX+8CiHJkQI5lFrjniBXJQgeJ+34gBSQOJIJX7hpD0WomaoPSgWySKuRKZt2To1uJCWB+vOw1r3E6nBMac4TnhLribaDBH7/qBTrQ6+luNHAsl8hijvjD9nRchW7xJD94Pn1/49MqFVkPSwfqBh2t1jxaMGoV0oG6R9aQuZN3XkOnuUugE2nv3qnHai7N3sVavaUjMNjrRnIyoNQR3uexr+dsUOdHrS/+1AgCa9FraFBZdkY567yrIS4SLQCm8Pgk9tGXbh+EKpSfeCkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct95U4tsKfdbK9z+Wg2tgFcS6i3+DRGQn1NrtD0g9X4=;
 b=P/IQyF45IrvQkyG0RFffWvlcTwlfokZDsMdvoHk9XdJU+JqqNjCresunSTkhyo2n8yj+v2iUCCiYOYV4TY/1PPtC4bIR4CnLu2biCrVw303HHYTfyApc9t3aBOLDiiEPKCQFMCnBp1G+OS0/OtTgBC09fcgiMR78F/MYfuuOhwU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0053.namprd12.prod.outlook.com (2603:10b6:910:23::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 30 Apr
 2021 13:33:51 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.026; Fri, 30 Apr 2021
 13:33:51 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: remove excess function parameter
Date: Fri, 30 Apr 2021 15:33:39 +0200
Message-Id: <20210430133339.24289-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [217.86.127.183]
X-ClientProxiedBy: PR3P192CA0024.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::29) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.127.183) by
 PR3P192CA0024.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 13:33:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fce6d4b-ea85-4c40-c546-08d90bdc972e
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0053:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB005322EA66746D9BD208AC2F8B5E9@CY4PR1201MB0053.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQLr84iUCqM3SVffIin7p5FtNdUoWoCG3wmm7UlQn6l1UbRtHdqiRjMQDWvD5kYc8n/s0r5QU6z/Q9SH+1uIvotiEL2RcxnJl7hloOJznTX0Rk4Y4ggF8ne0SQ61mbUYJ8iNgt3TpvKOkSKc4oUAUAb2Sg8dZbj71zbc+NnIQeyMMgAL2dfEdCGYV3pUaZmW1L43JzR1WpP+HSR1i+7wvMmpaOgKGs+xtygjlUxgQXO/+ajj/GifIup5KY+SvBQ9D4W97XsXVhK1kex3e+R5T2Z7PaAY0ycc+ekiJGaBzyARi9KqVWowRWowNm/H2W2mtrcKuUuyzB5bKOTgLoOwvVRnnsdDtP6/3ZHE/0tP2Pb8EyS3A/Hjy03NpwN8Cs4aSM8MGIxDlHbNQOx1FdwKkjo2buawB9eMdYYtyUNUZHbpkjc406rNPcvpckDEA/VKd+UP9a76jWkFSAkwOGEoVKIEg6uiliAMoxhjZ5poef0LMns6/uSCkRu/26Sw7QjQt0OXXDEXOwt8qNvuBmn6NhhG7x0apak4ofxbiiW3N6cH+/ZsQ7IX1tGF+dssBFqpBHrJficrBIyqdK6zvEKVBTvE5wRfIcnoGfQb2CLwrPPef/Xy1Qjw+fDOT0LP6NGv1Q3Pa4bi7lfGmmRcRbM08A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(4744005)(38350700002)(2906002)(316002)(6506007)(1076003)(6486002)(5660300002)(26005)(44832011)(36756003)(83380400001)(478600001)(186003)(66946007)(38100700002)(2616005)(6512007)(52116002)(6916009)(16526019)(66476007)(86362001)(66556008)(8676002)(6666004)(4326008)(8936002)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Atc2guTY2FDDcZFRH9AJOXNKcFGlZJ8lE8zONGO5wpfg5lVsXnvHeeKFCEeq?=
 =?us-ascii?Q?v5w9VoLvGw0aZH6T3xUIdYtjyNSfxuBBEkYpCPF6t1Ezed/p2+1u7usdsDap?=
 =?us-ascii?Q?8k0h2nu1KMc7AqdOtKIwJmwNG2z3UvfFPYH4RK7+TcCleY4RPCV3e/KPaaBI?=
 =?us-ascii?Q?jLh4Q+4ZIIRJuIw9FMSoI0wH6tkP6jMH2L3kCROwiLvUrwCeGrvk98idB7yt?=
 =?us-ascii?Q?oVS0Q0+YJk/18mgnRw6URYe13dh7vQ0FNcySua6rmShYDSGGKo0rkx6UJskt?=
 =?us-ascii?Q?kFalO3S5tbFVWCjcn//6wV/kT1W0HIiOG45Gxen9Auma1ZTKnM76cScZILRo?=
 =?us-ascii?Q?MYnPvoGh/pFA6WhCHyR6vxXn1uROWtOvHlUDBDedY9WEjSazMmSKjLN5VoLU?=
 =?us-ascii?Q?eXngOqasRx7OceIdfbk/68qZjBz/d0NjldTq8vLKXSjlJijDOe7Dh741OPkq?=
 =?us-ascii?Q?H3ULxFr9Ghn3/4d/vsCc5eRVaWhrzszEHhkVRE5h6SlcYEkC8kLRuLy4j9NA?=
 =?us-ascii?Q?mjMZZwxkLmQvFr+TJihMUNteOHuTtv6ftOajZMdZ6i8CO8tXnZpAcARdbY6t?=
 =?us-ascii?Q?Mah88XxbyLy+h+eRBzQGDvlkBVooyQB1hJHPRn/+LOV1XsPzvDv64RYWyHHq?=
 =?us-ascii?Q?MTAvu55nBHTypJAp/7hm1YT2YVq7bZYxFuoxMXEKMGi80m0b1ZI3tJ7pFU8A?=
 =?us-ascii?Q?JU3HEkLXZG5PAZLhgC9WgV92/fUHX613GkTw77KfJj6R3gdJx7H0K7TcG+Kf?=
 =?us-ascii?Q?KsxG9Ieg08VoQe1BdA+JtQrkVDX03gi1T/sNDIBJ9k0vbVEkv6tCZXQnj7Vk?=
 =?us-ascii?Q?xzEVzKClLZKApOpdNOtdPgRDBmKR+FvjO4c5tMzCp2JJ0dwvQ6AjNFtFpZ9J?=
 =?us-ascii?Q?p3BGk3AtogtugJvSxCgDwLQlmtXi9n6ilSAaI1wbL+ev/ZpOjSdSPEz5fMPn?=
 =?us-ascii?Q?QtvMh8HvO8+nJfwjusINc4GzkqjJbTlcAqwu7e1XHGm/X4envf++2bOKr6nI?=
 =?us-ascii?Q?66R0s0nXBMtscfvza/RSXfewUbqoL4bnWTNXSuk3l8O2Tv0VmD+VFSFus7az?=
 =?us-ascii?Q?zKbc2OR1+Jnfqz4sPoXQOtXXVuroWuNTlQHuUwSHXY7IxGlpsuSAzvYQkW5C?=
 =?us-ascii?Q?HJrK5+KOc/Ra/VyLH2Nqc1Q75Ms1tu54yhuzkDR/gmtg5OEgpOOj0L+aTIeM?=
 =?us-ascii?Q?ms2haTz8JWR+K6a8JKwph1Z4zFXOqSu7rpjSUuzp08BGB++ki3wmj1gi3wa2?=
 =?us-ascii?Q?E9arrkRdFH6Io8gRzMCAn509gTXBIH9rZv5VP3z9YMSrMaxl4CGqKGy35+Dh?=
 =?us-ascii?Q?sj3BBzeERslqKuu4mo+LttHr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fce6d4b-ea85-4c40-c546-08d90bdc972e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 13:33:50.9630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywg8S4+YwI8bZKCtAI3eiGEuHZkdJdlnmEyji8Z6LjNXaNcbOccp1cAz9qSfytnXj3v2XahvzC9iJm7b29HiMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0053
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Rodrigo.Siqueira@amd.com, Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix below htmldocs build warning:

"warning: Excess function parameter 'vm_context' description in 'amdgpu_vm_init'"

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index dae51992c607..f2513be72980 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2796,7 +2796,6 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  *
  * @adev: amdgpu_device pointer
  * @vm: requested vm
- * @vm_context: Indicates if it GFX or Compute context
  * @pasid: Process address space identifier
  *
  * Init @vm fields.
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
