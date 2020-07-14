Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BF5C433E7
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 17:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF93A225A9
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 17:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3k8lsHk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF93A225A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B75156E0F6;
	Tue, 14 Jul 2020 17:54:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C436E0F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 17:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms0Jz6yamJ/xnZczKueGA8eD/t+nSKXcSaC5VfJIDn8LlGrKFkyfR6Sj5roMaFHRR+k1S19Y9AzvadopW7lnOnnL5jY8xQkMowTqEpwCZIotGDxvep8vtWteBg5csCSDA+d3DdTmjTbq7N4wTREIBBTQsjAFqWeqJ8yUW+AfEPDlWJ6FrU1tL0caTa5iPuf+omuQJYAmJCJrejiYNPgzwd6JVDaKt6dj/58B3r117cC5BHKjCGJMYQuC/bE/sTE+RwTpIrr8QYvLR7eqbV8GmK4xEE5OjEyVvQIpMefqXo2xjrk3/E89hhpsaTp5wiXYzWnvfdHHVa+Mo2KU4flDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9x08YdDJSUG/R+p0FJeQVw9b6nlVmuE9G7txmPL+KU=;
 b=Oe9lCTwXCQWfl0v4t7vU2xF5Su/rhDNXBnpLECoIPvBOcVx1noIPiCaMmaJgNYGMom7rYzCLsBtGc9kme40flvclvFpBamrNTiyEtQAHQfX3x0+Kkhq4HGhyo9KBfxajC7r/BoKroeFhATqJTJqaZSdBXnnQ7JTIl/X9DHg9PhZWfOF/EPkbpU9Lm2+SMGaQL4iNMWCUdjSjeo9/ZPBRy2WD7mNOd0/mgkFu+mhqWq0pObgREevUF+uB6y05zOj1ULWAATulbzjX5+WBxUr/e5YBrDN8EI/5Eu4okEW4uql9CVFfYZUwV/L8AkQ3vYgXPEOk0Qve48mrnFcA+bZkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9x08YdDJSUG/R+p0FJeQVw9b6nlVmuE9G7txmPL+KU=;
 b=3k8lsHk8r+7qd9iE+0+fSdIEol0BoU/KAMB9cDIUCUsuX9z89hNInn4S2nbgvV+ppYXdcWveZ/NX+jr1jKThqS8XxSa1kFbkIpE6SRNhmlbvi0F4gbjllsViVtRRUFRXJUAl4IA2VYN09vM4McgsgJ0IGqZNjzMBNpyw7GN4+vs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 17:54:27 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::9dc3:cdc3:f733:39cd]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::9dc3:cdc3:f733:39cd%5]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 17:54:27 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: sparse: fix incorrect type in assignment
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 amber.lin@amd.com
References: <20200626233951.11724-1-Felix.Kuehling@amd.com>
 <39c3aad4-3676-1ade-e56c-db9cf8573e94@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <eeae96ed-9dc9-bc46-9859-e5b3ffa189f0@amd.com>
Date: Tue, 14 Jul 2020 13:54:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <39c3aad4-3676-1ade-e56c-db9cf8573e94@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::44) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTXPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Tue, 14 Jul 2020 17:54:26 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 61d98e13-84e6-460f-ba76-08d8281ef35b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2940:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2940F2F24C294ED0262586A9E6610@DM6PR12MB2940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:176;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QseRpxipJo2pj0yI950vughEOaYi/ANAwKZ4wC6X41rnYcxa66tZiGO7WQCZ/NTGQ4FBL5MxtBupS1RWPD0v2+SXhY6r2XofFLktpuy55IXKs+nOUajaRvJMbyhPg6DOtnXqF05iqzZ+mjcTD6Escyqxq/P3W5Fwenl8ErZB2ZhweLZBp5eZ0l2PSMzm4Xr8GeKbK0Ub5Ianbrk0PinamQc0YPTlnSvDXVGzTMk85XK+bcVfZllogQs9yBP0JwGo5Fh4cZZPode1E9WkC+OWRt0Opbqh68Qne+DP+CKAwf2ghDB1ZB3Pceb/fX59e2znseY72jvnZs747DFFZoyYPQUtwBRwbgPj7U5Ohy/XkLgvl/nBZQP86Thx/1QDkBdErY7jrvF2fn35tbPvdoMC65uP0l4KHyLHCFUrIzB6Wzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(6636002)(6486002)(53546011)(316002)(45080400002)(31696002)(8676002)(16576012)(5660300002)(8936002)(966005)(52116002)(36756003)(478600001)(2906002)(31686004)(66946007)(66556008)(2616005)(16526019)(186003)(83380400001)(26005)(956004)(66476007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OQnVTjzAjc8ueK9vre3puZeojoVvZXWabrVWFuVq/2RGqgKrB6KdMKKnuQgG2knF7xD9sVHiKc/OTuicX1CfxNf7hdQ5MXcyDF0IEZJqndjny/0MYKYnSOewrHCG7bMVPkyTyQvj9pYR0bM+2DHHAm7zTvkCgiIAwuCV/UhoNMXvK8xwLqSuBbCivfeRrmY/phMhsf0tXrqbiKvN9zFAFTE99gtjOFh3YlGOkzdcUTpgXigSTwyH+52XWrHR0zPX4p077ViXDUPYvg0XyQfOUeB29s8YxpAYlw8bx3aE3bupv4kNWIlewsowQEaHJL1IvSrPihCWHGuvccxjwuuAd5/qVaydoAeI2E7/oJujvEewS4NMzfhUbguXer+UUGvWNxVTVDZn/fnrjDpRE70XkejhGWISpcKSgovY1JIs+YVwaNubFzl+aXjaah0RZcHQDPykz0lJWeZDRJF/o2yWParQfmwLr3Z+awRIMBtFD2Vw6pWmbT0gJCi4RlNLGOvp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d98e13-84e6-460f-ba76-08d8281ef35b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 17:54:27.3178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4zXCpYgmGZlo/1yaJHJDPBqA5vN4AqxnPqT7cJf8fVxU1XIvNLxYx+5Abt9JHXH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Philip Yang <Philip.Yang@amd.com>

On 2020-07-06 1:45 p.m., Felix Kuehling wrote:
> Ping.
>
> Am 2020-06-26 um 7:39 p.m. schrieb Felix Kuehling:
>> The correct way to implement the fops->poll callback uses EPOLL* macros.
>>
>> For reference see also:
>> commit a9a08845e9ac ("vfs: do bulk POLL* -> EPOLL* replacement")
>> commit 7a163b2195cd ("unify {de,}mangle_poll(), get rid of kernel-side POLL...")
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Fixes: 73b753a11ae9 ("drm/amdkfd: Provide SMI events watch")
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> index f3782627407f..7b348bf9df21 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> @@ -59,13 +59,14 @@ static const struct file_operations kfd_smi_ev_fops = {
>>   static __poll_t kfd_smi_ev_poll(struct file *filep,
>>   				struct poll_table_struct *wait)
>>   {
>> -	__poll_t mask;
>>   	struct kfd_smi_client *client = filep->private_data;
>> +	__poll_t mask = 0;
>>   
>>   	poll_wait(filep, &client->wait_queue, wait);
>>   
>>   	spin_lock(&client->lock);
>> -	mask = kfifo_is_empty(&client->fifo) ? 0 : POLLIN | POLLRDNORM;
>> +	if (!kfifo_is_empty(&client->fifo))
>> +		mask = EPOLLIN | EPOLLRDNORM;
>>   	spin_unlock(&client->lock);
>>   
>>   	return mask;
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cphilip.yang%40amd.com%7C1359cbce5ac84b5dd02608d821d46a48%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637296543503819875&amp;sdata=Q1KlOB%2FlF1GdUHTMD8a5NycjBDGhSDxo7qlIT8kyXeE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
