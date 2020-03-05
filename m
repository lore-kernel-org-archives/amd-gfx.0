Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D86C3F2D9
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 09:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BC52166E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 09:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="unBn3+9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BC52166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA516E171;
	Thu,  5 Mar 2020 09:06:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A45606E171
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 09:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyYNy/xH501LWzcoHFpvCZDfUBAS5dEZo4JegluZvbYQqW1UMjNyx9WT8s52NS7v1kRF8YXHLjuPBnS13UL33aLrENPGrnafcdMlWzDAybdkPy+kR7nqlEvmrMIkJQXqKjQbsw0YIukQ4eC/8/vYYe0nbjjYT1zbBs59jYyMB7e8exPTuJVMcVyd5PxaM/EWVMds15T9rPR8+wG8RYLVLz6rgO2cWKi+hBlsgL6O+iyKOLH4CU7n3SvJgiBQlIIBSIwwgm+Wh1rTs+gLlOjke0e/5c9M+NbNK/3lmXSTy2LPbsEHjQpLQnqzYh895BTfZkwmd6xbsyZrbbdVVRPdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcFILHm4mfSHSeHaut/Cqpi+k0UXFTLcMpcPmBE8+48=;
 b=G0hN0x8PqJDyJrcyMWnILrKDwCBIqAdRBayGVgDX2qYsABFKW8W2pvXIQf7gAXmrsJFYI6PmE7Sy77x8p1FeVneIG1XW7z+V8f5ScLLx8usEQ8XG3p+SSHhFjTiw2FTFKRNVAsjlpepnoL3rHQ6j7gp8A82TGmV/rgOT9VfQ/3t2L2QiqdRyPAfIJcIiCe0uynXRqaq6fbVlrLOoYkeKqSQeWjtxFU8nCSRCAcSypuvRTGZzb1bBTiJnd3qf6yarRi3k/0bukHCuUxb1kgvxXu5CCDF+Bt2ZNOkq51SkyMCsxjPm8MCic9xjMMYgD0VYAFQYmnOl9GurAXMym7485w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcFILHm4mfSHSeHaut/Cqpi+k0UXFTLcMpcPmBE8+48=;
 b=unBn3+9svfPutqAynEJUK5e4hkNM0sCDgbnbvl7V06DHH0GJSR2nFDz995m4fnvSBnOgE8i6tCcS/COyo7zVCL9JWytfolmJOOLwl51aexwoAbouakUSmWXzCgcXLTl72lLqRsGhuPtMZDnkff9m5mfClS+NRTS8HQ/7vW3DNUo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB2424.namprd12.prod.outlook.com (2603:10b6:4:b7::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Thu, 5 Mar 2020 09:06:40 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 09:06:40 +0000
Subject: Re: [PATCH v2 2/4] drm/scheduler: implement a function to modify
 sched list
To: Luben Tuikov <luben.tuikov@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>, 
 amd-gfx@lists.freedesktop.org
References: <20200303125039.53141-1-nirmoy.das@amd.com>
 <20200303125039.53141-2-nirmoy.das@amd.com>
 <dbbe81d7-ff99-b85d-ddfd-1f3f13322d53@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <7b01f363-5048-308e-e51a-9391d4dd58a6@amd.com>
Date: Thu, 5 Mar 2020 10:10:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <dbbe81d7-ff99-b85d-ddfd-1f3f13322d53@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:404:8d::21) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2e:a500:1f22:cf19:9085:11a1]
 (2003:c5:8f2e:a500:1f22:cf19:9085:11a1) by
 BN6PR04CA0071.namprd04.prod.outlook.com (2603:10b6:404:8d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19 via Frontend Transport; Thu, 5 Mar 2020 09:06:38 +0000
X-Originating-IP: [2003:c5:8f2e:a500:1f22:cf19:9085:11a1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f9ae185-0f3c-4a05-2f98-08d7c0e48436
X-MS-TrafficTypeDiagnostic: DM5PR12MB2424:|DM5PR12MB2424:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24244B2015F551E1577B2A678BE20@DM5PR12MB2424.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(189003)(199004)(81156014)(31696002)(8676002)(6486002)(81166006)(66556008)(66946007)(66476007)(5660300002)(6666004)(31686004)(4744005)(4326008)(53546011)(316002)(16526019)(186003)(2616005)(8936002)(36756003)(2906002)(110136005)(478600001)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2424;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jYVdZMrhSNho0d1NgqPDnmb6ygVkIqxXFkMzHUnBy9p0JDsbo0zjhEEMXI8j7o9aFW+2O5632zWGuY6w/y6pQ/PnURpvdy5+wrg1tE5Odx+BzhNFo+Siyf7+GCnKpnHcpM08e4pmt9s6cltD8BkcC3XqPDBTJ+MxsAAKN8GGnj51luYXEU7NyXhFWGBxKLYodCAv4USJT8RGr8xln0pkYW/lJsWcc7YuB62n5sV4/5T620xfPGvSvB0yUseZpdKOQ/MPl3beo2bogTxy2qm6TKQIxZ6znTmm//eYlo2/AoXGd+wPRIQ9fvx19bbW1021G1VARI4A64aIC8TGAR6dzeq6jitgLCWxAbBW7Hp0mBu44m2K3UES7bQYmm+T1UiGJCHvhVjZtVtqcaePcWUyLkfRPJQF2cJHJTViXGaMWRsqqU2hRBdqnHyDJffcUdtC
X-MS-Exchange-AntiSpam-MessageData: Uj8pA9R70kMuYsvYYYC1HbVvV0IRXvAoocgeyt1+IefJlEpDoem1esIH2hl/X669eClIbB6oc6I6XafiQMxCjsmyDTnA/rCnT0kZwki31CvpRAr6UEeJVJlh+dYR3t7rT2oJSMRkL88KXIhdqbShTtopJaDj0Otp8w8M7tr+TCJ8BK9ZWZQugInUTSs70GAKFlrlWs/o8gD7bOyS05PVSg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9ae185-0f3c-4a05-2f98-08d7c0e48436
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 09:06:40.1613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNjFNcuGElgItK+QbD/qbA7wNm9HSOtSQVTtc4ajYCCeXaZGyGr236sa13SY4z3sBYWbPAfpXv9QHgAjmFpFeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2424
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/4/20 11:00 PM, Luben Tuikov wrote:
> struct drm_sched_entity *entity,
>>   		       void *owner);
>> +void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
>> +				  struct drm_gpu_scheduler **sched_list,
>> +                                  unsigned int num_sched_list);
>> +
> Again, the argument list here is unaligned. Please align it
looks good with cat and vim. Not sure why git format-patch is acting 
strange in this case


Nirmoy

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
