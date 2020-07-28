Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A4BC433EB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 18:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A7D420786
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 18:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wNxCKZoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7D420786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85366E25F;
	Tue, 28 Jul 2020 18:48:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57ADE6E25F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 18:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWFqKeqK/VPbRfpUineY5IRUHDifELLnSJBZW18ypMBkNXpviwhza/cZj5gUET5HKMTzX9+aqy9MZibuS1A3Ofmz2pmyNag/Q4jKKYXe7AQotw2VYHluZP0bRbnN2UIkCY/LN8cxg5/4MHZoKa2OuP0Cgc6BFiynL4VusbAUlyPIsdf0npRK2B7gqj+hS8DyagqcCQQ2lZNB31vRzjQ/UeGdhY9WEpULSLa7EP9sJSZ+cubAPDLY+4N23GUh9gTdX9QFCqkJkDA5i9npiTrBxOUGChN36JplYQA7wIPjKJcX7YRwORvYl6EJe+UExFWz/BMLIp/hieX8XitESrXfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5KTaMAGetvmlgopi7hWQSXSgQBlFCcUY6z1QC1CjbU=;
 b=klm1MEXlbUBSQm9RtqcRY2nfDguHjpuI/c5r8vUU/GtT2zK5f4l/l7uaUgxnW3U3bmbbMyxhOSo0lFmFGHzdjAzC0WeYujBf1cMg7Z3zZ3KjZYWQPwDtOJ7+N6makHAqeKEk++2d+RmvEhblPfnV8tLSwBntLRIqoB5jB9JNIk58uSDBLzZ57UtPvQrfWK4L/aHoLW/WoL1l0rqbjiJq5h2WwHXfKmSyZNaqDBjCgYeY70/3xmpHN88Y+0GvL6/oBp9eeP7Oy4d8IcxCkWRbDDn1HotrhPaHq1WkScDwF/itHBtir/sf4vW8TDdPQw5x+/iiOxxD7/yVhzM4haWB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5KTaMAGetvmlgopi7hWQSXSgQBlFCcUY6z1QC1CjbU=;
 b=wNxCKZoOmRV0Qpx7IqxvKfvZJMTQ0YmCztORtygfXgvk4WdsXVlLLQPGryE5T7+zkVEYiWN5CMGmLbBhybeYvoTJMJhFsKxb7S1gV27ip/COuRFafcR9XMdEWRclIdTZPu5PGdOAN4GvVqUP2tn5u0/GI6SamUfvuSF9VFJiw5k=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12)
 by BN6PR12MB1443.namprd12.prod.outlook.com (2603:10b6:405:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 18:48:49 +0000
Received: from BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d]) by BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d%4]) with mapi id 15.20.3216.034; Tue, 28 Jul 2020
 18:48:49 +0000
Subject: Re: [PATCH] drm/amdgpu: fix PSP autoload twice in FLR
From: Luben Tuikov <luben.tuikov@amd.com>
To: Liu ChengZhe <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200728022929.411527-1-ChengZhe.Liu@amd.com>
 <e9cfded6-af16-0404-ca7b-afcc4a285427@amd.com>
Message-ID: <d4471f87-9d85-8257-0acb-836e8270ab91@amd.com>
Date: Tue, 28 Jul 2020 14:48:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <e9cfded6-af16-0404-ca7b-afcc4a285427@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::14) To BN8PR12MB3124.namprd12.prod.outlook.com
 (2603:10b6:408:41::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0135.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Tue, 28 Jul 2020 18:48:47 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4bb7977e-9e68-47bf-0f77-08d83326dd5e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1443:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB144399D4C7102660A5EB0E7699730@BN6PR12MB1443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qt/7pc2/TGmdC2BkIsmU8eIBOEo4PCdN8dTzl+KAXVckWaPosLs3UIlarPHkIpZ2TNgAPxn4FzneII9yuCTkxul+tE2SCnfPeWGpidLvzHWVCxUyBTx4nwvsS/1oY7eRs0suzHlxqcJFH7YeLbwkqDjiiNl7qJaWeXS2pSPtB8p7Lhluacy6dIpg4ViIN6S2Wp4MZGjdlniJEBlpmDKtSdYQQF1JksxLnrJezJhwbZ7rktXPFdVCC8aTaVr1IQRtFNOjFcBmPVzEvdlLfHGPACZrIxECoOyG7BGVFEaCvFbnTS85effT/OCAi01kQmWPLuwVgP3dqJXa3NfMO4E/n7Ipdr2PnGcgD17RYDWneIfQOOJVD7iIDw8m+FZW36AS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(2616005)(26005)(956004)(5660300002)(31696002)(83380400001)(52116002)(44832011)(186003)(16526019)(36756003)(66556008)(4326008)(31686004)(86362001)(66476007)(66946007)(53546011)(6506007)(2906002)(8936002)(478600001)(8676002)(6486002)(316002)(6512007)(54906003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: J3xQ3oj7pVWGYENI+eIxuS8wiLTjj5aCkjh1L1p/E3qKUeJUZIGInIT3fvkVbnFnClBuK84lyN3e95ogqsuxPm4HBkmYcUvFrcVwhIdkj0ep/6djYHKanEH8EPI03IV9ZHItCI1xN1SLUVQYFIbgPDnGg1uLo6Cg4ynpjJnug44K4HJnxUBup3SOejX4LGKM532hOx9w5iOemMKHmM9YJ8Jzf8pUbzZJSEf4F9GmZthFfv0CfY2JgC89xfJFh4CvVyQaPYmaLUiFbLeGKpNSjQBlQNzi5ODNI07bXQZEu4kPeoxGadodZfm+PGilZw4xAtW2NLNsNM1wLaQ29R5UcFQXUg826gSXu12XptHB4BgGiXTCwIbijgfWYXq5zgmazAID2Nf0G86FERNLB78QebsQDd4LKb0tH/bp2XTmjixtEuRE0pru37onJdTnEiVdswiAmn8YwAcrpP0NeChoL2lZTILm4w7Zb+kMk7V6SEY2UoqtZbSaugraG+JKSImt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb7977e-9e68-47bf-0f77-08d83326dd5e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 18:48:49.1296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXMdLGfuXkD7T16l3ghyKIYcDuUKgOpGQRCubha6rXZv9KTi+JvKOWB9XBccwLJm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1443
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-07-28 2:04 p.m., Luben Tuikov wrote:
> Thanks for removing the braces.
> 
> On 2020-07-27 10:29 p.m., Liu ChengZhe wrote:
>> the block->status.hw = false assignment will overwrite PSP's previous
> ^^^^^^
> You want to start a sentence here. Capitalize "The".
> Also don't use future tense in commit descriptions (and commit titles).
> Simply use present tense. Using future tense makes it confusing if
> this is what the code used to do before this change or if the code
> is doing this right now as someone is reading the commit in the future with "git log".
> 
>> hw status, which will cause PSP execute resume operation after hw init.
> 
> I've found it best to describe what's being done as if telling a story.
> Break it down into "tell what's happening" and "tell what what's fixed and
> how it affects the rest of the system". Something like this:
> 
> 	Assigning false to block->status.hw overwrites PSP's previous
> 	hardware status, which causes the PSP to resume operation after
> 	hardware init.
> 
> 	Remove this assignment and let the PSP start when it is told to.
> 
> Check if the above rendition of your change is correct, and use it if so.

Double checking now, since "resume" is an op, you should capitalize it.

"... which causes the PSP to execute Resume operation right
 after hardware init.

 Remove this assignment and let the PSP execute Resume operation when it
 is told to do so."

Or something to that effect.

Regards,
Luben

> 
> Regards,
> Luben
> 
>>
>> v2: (R)remove the braces(.)
> 
> 
> 
>>
>> Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 62ecac97fbd2..5d9affa1d35a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2574,6 +2574,9 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>>  		AMD_IP_BLOCK_TYPE_IH,
>>  	};
>>  
>> +	for (i = 0; i < adev->num_ip_blocks; i++)
>> +		adev->ip_blocks[i].status.hw = false;
>> +
>>  	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
>>  		int j;
>>  		struct amdgpu_ip_block *block;
>> @@ -2581,7 +2584,6 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>>  		for (j = 0; j < adev->num_ip_blocks; j++) {
>>  			block = &adev->ip_blocks[j];
>>  
>> -			block->status.hw = false;
>>  			if (block->version->type != ip_order[i] ||
>>  				!block->status.valid)
>>  				continue;
>>
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
