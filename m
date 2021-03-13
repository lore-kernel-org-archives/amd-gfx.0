Return-Path: <SRS0=AASI=IL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFE5C433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Mar 2021 02:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B4464F48
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Mar 2021 02:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B4464F48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78FA06E087;
	Sat, 13 Mar 2021 02:44:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05DB36E083
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Mar 2021 02:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hse+WA2oZWKxsOw6CMdQZQqhTU7O+COa12KYT70pZykCE5bpxEU3E2Gbw0w8hw4hiQ5xLZqY9CjkSQNTJbkwmPtAGaMNLwFJCz2rx4VVvnX9uy/DE6QYGp5OA7ixb4/Q5+XOAOIP/IqTZ1Xm9eKSSfsqH0a0zTZQXt0cLQetcaSGFUotnytY06ev6hvBmsLZc0OhOVaL0QwUqVC5W/JpZYE6W8U1g7yaiuhzk62SM4gTFGDD63a2Av4IJK92Xjnfn+wcE+6pTVfH8c9+zHPNj/a7YuopDIAT1+4UgHXRFnYenu1Z7BFydvDIN5hsANt0N7qC/CuJgjtDYPphTaI/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKIQphbj5TFCyvjeJ5XaD9dvDkIuo2RQmq0G2lZP0TU=;
 b=eTUf2mDOJ83pTJhDaC2+idvinY4eAPWcnJwYfWH2v5/fE6Vb+n00HC5IZV/wZlpqZFhw+tNKZlzlematEAk6brd3SHeKpIcKKqp/TNxoCpHRSInHQDBM8ogGk7BBBoV6ocvPpoTI5FtDK1S6yj8xqWR5vbSwMAqRT4OqBnszib2ijaxIQIPO57Qd1Badod1+7ZNg+rw0hpCPoDJYK+Bi/aiJVZ1ck8sqUvlqKIV26d1Yy5rc2cUz+FYRz2FLpxg44/kpnGm93ASKLY6dmYYnWq7/jbokoBcEURywCWgEBqCK5jETshe+Z1/eJWmqLRj8xhXuEMQn05z69OHfqMeHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKIQphbj5TFCyvjeJ5XaD9dvDkIuo2RQmq0G2lZP0TU=;
 b=CEkCgahRNipcrM8Nh9feBa2fPLYGGGlvCsARivevO5j8ssVUiMHdSGE+xCeA3xYk+JlJxtA/ZPeX4aeDyvpOl6xUdSNsr4mZzPaR2pS0Ou8m9D5ONLH+ssewHhm4BLRPGiU7rob40qRvv3hojll0l4kt+TclmWd26QTr9YEpTnQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sat, 13 Mar
 2021 02:44:08 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.3933.032; Sat, 13 Mar 2021
 02:44:08 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/2] Two bugs found while rebasing my HMM branch
Date: Fri, 12 Mar 2021 21:43:49 -0500
Message-Id: <20210313024351.10908-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::31) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Sat, 13 Mar 2021 02:44:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7418631b-3f1c-4a05-7534-08d8e5c9e00b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4223:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4223675195A9C6A7800625DB926E9@MN2PR12MB4223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wkj1DHh0rytKYW4aBxyKHnjI1tGc8DOmrZFNrjkZm20ZVSr9tyqb2QUTm1rmJmSrpA3L6at4TpIj3bwmrBZf9D04mZhq5eINgvFlL1+6Q1VpNsFfsP7mfYpdQd09U1a7o0SwOuvkX4IsG406fZ1GT2MEg10jXQucK0BoBVpsJ3dDn36Dz/Axi+MPwnGdnorCHyDxN3UrhfQaszP87Kt2G2KiG8wQtpNWxAEdRQ/VcsKgz++SpdZj8SkZFnn36Ptc41kb4mqQRLIi9qX42PlEVhpT2+1bWleEb30+efpFSIKZpd2GReBvJj6MdGM2lpWyHQPuJo1u8Vf5UCBA9nMPEKrCWMkiIu+VKTmLLJ9Bpxru8b+4S9U+XHJt8krPDWbju8OJkSQeWx37rloX0cZeC3IaD13O+S0Gzt5pO7SkIRF6dIwDptR9tXyoP9DIfcLok8lsXo7946gNLyuuIIWUIwYLDteJrgnfxxudEXOLm/1B2z3pF+RHIK8awRiz2WcYCJVx9Py9gthLkLNsjsaBBGZLXJWEMfel6Cc9DlUe72ZpI4Uh+fooQB53dWTcSnRI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(6916009)(66556008)(66476007)(478600001)(66946007)(6486002)(8676002)(36756003)(26005)(8936002)(316002)(2616005)(52116002)(16526019)(6666004)(186003)(5660300002)(86362001)(1076003)(956004)(7696005)(83380400001)(2906002)(558084003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eHUxb1Blc0Q5UXdxcVcxM0FRTklyVlZpYUdSZmg4YzBacElZU0szR2Q4dnkx?=
 =?utf-8?B?aGQ3TFRwZ2dtWDJocjVURC8zQ2Rmb2cwK21NMlcrdUcrdjFJaUtHZWVSazN2?=
 =?utf-8?B?WmxSWlhyOGh0TmVEOUdrY2o5ZSsxVXBUOVpMTEViaDJKVWVqRThaR0phSXUr?=
 =?utf-8?B?cDQ3UUNudW5FcVV1eEQvdjRiQjRtc0hRcUNnMEg4MW9QOWNyOXVOVnJPNUZ0?=
 =?utf-8?B?Zjk1YnVPWUoyM01kTjlaZlk2SHJhOC9Jdnpya1VxaXNJMXVodHoySWFhT0lr?=
 =?utf-8?B?cGFlM1FPMGdySSswQWl3VmRydUxFQmpma09SbjVub1pJeGZKdzBVWldpZVcr?=
 =?utf-8?B?R3ZpMU9pWVl0M3E4WUxyZHYwYmFET3l4U3E3dlpvc2RqMnRBdWtJcVRoQWlu?=
 =?utf-8?B?WWRVOGIreUVWQW40R0MyVmEwa2Y2ZGVFdGltcEE5VGFBZVZrMm5iZXlMNkwy?=
 =?utf-8?B?cWc3T052eG1Ha21qd0F4YXppYWhiZkNSYXhFVllLd1FlOUgxeC9aeHduN3hI?=
 =?utf-8?B?WEthMlh0WGRnRFZic3JHbDQ5OHpmR3VBQmR2VG9kQUVyZ05kQ3V0MGI1QmZP?=
 =?utf-8?B?WHB0MGo2OTJTdlQ2VXhsS001VEVodzkvWnpuNVpibU9zZlRUaFZ0REVscEFx?=
 =?utf-8?B?bjIvTDRncVJBakF3cEtkeU51Q280YVZMNWx5LzZiYy8vNjZkVGZqZitkL1VR?=
 =?utf-8?B?YU1NWnZsQW83WVhxcjZNNU5HVFNnL3ZmeGFXU2EwNDR1Q2Y3VzVaeUpQZUtl?=
 =?utf-8?B?OHNaRlpQSTRhUVJENVVLRGlFSTIxYURCRk90eGJJSXVmejBmRG5nMFNya3pz?=
 =?utf-8?B?NndzTnNGY2tuSnR6QjJhYm5ldzhzc081akVxZGFROU04c1dGeStpUmtXQmtR?=
 =?utf-8?B?V29iR1hMeCtVTzBmcnJFVUZ1dWVRSFVzUm9lQ2pGcGtVL0xsQi9mcUxjWnd2?=
 =?utf-8?B?aW9temQ4eFV4QWFCTDBYaDB4WFFJOTVEb3Y2QU1qVkpaWlZBZXNpQk9mbFFY?=
 =?utf-8?B?Z0NBRmgrejl4QnVNNXNMRmhJeVdyUm9tbDduYWZpcGdpa3BqSDFzYXZBRmZk?=
 =?utf-8?B?b2luVlY4NzV1L21YMStZSklOR1dxZmJKZ2toMlJDZk1aaGNBRWg1clMzemJm?=
 =?utf-8?B?d2pPQ21nWTdMT1JrZ3NCazZaVklzUERuZS9oR0F6ekhUL21KajM4dG5nSlBp?=
 =?utf-8?B?d25wU3RYUHZHQkl3YVRLS1NnL3J0ZXozUzNoTHpJaGhYTWpFNmJQSDZzTVpB?=
 =?utf-8?B?TmFSZjZmSEd0WWord2IrbkI4YVg5SktmSnVPVm11M1krRWFvOGU4dDhra1pS?=
 =?utf-8?B?SW1iNVgrUXl6T1U3N3FiK3Z4V0J6bnpjenNPTDlwL0NjTy91bFdSS0l4aEJo?=
 =?utf-8?B?WmV3d2JzdVpJSUN6ZFluaE5mTmUxMXYwbFZiNVlSYzVMUDdPREZoOGZNY0ht?=
 =?utf-8?B?OEdEMEd5YXhSZEZEWDR1YWUxUUJ2WDlSZlhKUkd5NkxNZEpxcElyaVpzR2hB?=
 =?utf-8?B?RHBPUGVEWVhmNVFvZGk2M2t3SjNrT3pIN0JnMUJMTysvMU40TlJqd3RKOGFv?=
 =?utf-8?B?NEVtalVqeHlLaEtRODh3LzF2SS81azlEdmhoNUtub1V5OERjVnQ0elk5WkFP?=
 =?utf-8?B?Y2hkOHhRNzRDeE1nSVZnOHZoai9KYXhuSENjVHF3VkVYcEkxYXdyaXNGRHZw?=
 =?utf-8?B?aldmUWtjd2lvT1FZVTgrZG83WWlXUFI0dUx6d0F5M1ZmbnJNUnNtd29UcFBZ?=
 =?utf-8?Q?LztwRgboTclWhZSrBoNzzRnm05etNVmLZHMA0XG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7418631b-3f1c-4a05-7534-08d8e5c9e00b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2021 02:44:08.5717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApRKKaQz8GuSb5SJvnZTxbb76t+XSoU+HyKIWv14I/JY3rRne35rJvopB7L8/cUtzwABNEy7xoUvWXMkc8/uyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Felix Kuehling (2):
  drm/amdkfd: Fix recursive lock warnings
  drm/amdkfd: Fix resource cursor initialization

 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
