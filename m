Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F4CC433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 18:37:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE4D64E34
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 18:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE4D64E34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ABEA6EB6F;
	Wed,  3 Feb 2021 18:37:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 263DA6EB6F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 18:37:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuB1H+Qqdvt0QRQnYU929laEefu1N+n2wNzAw5BKsBQY0h02KsSyWGJs9Jzc+2AClgO68RWC6y01sA2UQPzIsw/xTJZ44VTgcjp+I9eEvikYV6OcGsfAYk7aBOPJ0ld6qvt9l98JiR3XKDuqyIAlHnDIN7tS3TeLm2dQdYwhvNRgqyae08F8quvjBsbrN+Y9r7vawOs6rbfuOrYt2MNSXzvUQQOKjPEChsDkbrK0DW+GWmX7wfvOqPkloOavcp/OBP5lnOfjz2DLa4cU4kt6o4J9QGpt8qxoARHiiU9SIMYr9ThBRyf+PbEsQKwDJlhn56l2j/FUBf9vmxcJfOdkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BiztgrW++SWESpJnhEJJFxcvVNtPnHeD/xIgcLq5DA=;
 b=MhuXJOBo9WqgBtsONo+yH6rITuzDmT+c5VQ5XpTUhUlIJ4RCh98GaG0XBLbxRDO508owPPdPUuUfl1K+YmeUyWjzh9iuCr2uIAvhxHpkRtfSGNv3za3e6X9lKdlsLzKzbx8tm7tPYeos4HoK3DqV+RSyi//bwqjv/jWFwhDwMW30rCeFoJNtH4Dr9yz+HOB9XaYIvNlctA4Uzgmmw76BYE78OJa/5klHHbmLnhR3qYyAlQmOzOXlrBz/N9+Co1Y6fCIDkYYQeVfGJWTW+vdlqflriG+DF/ShYox8HXZ1Fs2t7DIljCOqZKyaNPr3T5ipusbS87pJCI4zjZzF/1LwVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BiztgrW++SWESpJnhEJJFxcvVNtPnHeD/xIgcLq5DA=;
 b=gcbuVTGnW1cW/TmC4dLP2LU/mA/NYZVTKBjlAOL2W4Yifjj1PJcWJ2kZGBjI3ZHhhZvJvfCUMtJIJXwCi1G3ylb7VOtmTgNEb/+S6Jf5kdZoEvLAubObJlEFxM9ZmO9gBsrje5coFvsQ7CnHs6ftWkGXH3cQh3B0B6ElfVG124k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Wed, 3 Feb
 2021 18:37:43 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3784.022; Wed, 3 Feb 2021
 18:37:43 +0000
Subject: Re: [PATCH] drm/amdkfd: Print unique_id as hex instead of decimal
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210203182240.24259-1-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <26f70030-4c26-9c71-e4b5-d090b5d8cf49@amd.com>
Date: Wed, 3 Feb 2021 13:37:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210203182240.24259-1-kent.russell@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::12) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19 via Frontend Transport; Wed, 3 Feb 2021 18:37:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f22c09e-d4ac-406d-8d99-08d8c872cada
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4342953404005FC4854A2C7D92B49@MN2PR12MB4342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1uLHUdL4AnAKtwWHCVaeHaLoBVwoqqiqewyCW6WG+VlwCjMM/h56pr18kAxBXWj20XTqGT8eqOJoTYJ8l11rk/L7kcUH8/cLBttjPyh18HLFKuz739Z655lGz64Vf3XAkU3P75XvFVt+cR9z6ChjYRBdhYZU1EYnhCzsgb/mw5YmIQIJZkro5mEChvYdKZ1Oaz0uK9al6Nz2U+CXrD7Gx66ddZU2vhkGeZH4bqBdUqJWG+tsoIgWrHHtmYRFhS+5FH12iMT0l76k5H2l+QS0s7/0ljoYOxgZkWMTvPR4fPzsKX5c7yvCKoeKOFtEyb0hfj72P8G/N8VIlS8OHpPkP+9ihTeintjTbqzg+isiU84Yb490wYs0fn7Rimv2V7LntbtfmnwGVcOrDLCClc6PYsqV5ovGZw9I5pnlonod/0UhM3qZokGW50F0QNAmnpDDy2gODdUWDL9GBbaKyMTIZfxBFZeBnrijvY26DA5Ob8NzO0fh0Ra+kQ2m+F/U4x5aMKH4YVFNt4PUQNUGaRQBkCAq4ZY56vvkcRt7m9qw4o/+b1/lzMdmtbIpuamf9hHx4n3jTEFhXaiRAboY39c3erTGWRshrBn3b0Y6V6n/pQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(6486002)(2906002)(86362001)(8676002)(26005)(31686004)(16526019)(5660300002)(186003)(956004)(52116002)(66946007)(2616005)(44832011)(66556008)(66476007)(316002)(31696002)(16576012)(478600001)(8936002)(36756003)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M2RkSEpYVCtwT0pNanRJU2dTbVRRWjQ5VU9rRno5OUlyekhIWHlqNTZHckha?=
 =?utf-8?B?UUVJOVhZeEhBdVMxQVA5eHRIWm8vOGhMOUdDVmNuand3dDRkUW5VWDZFR0FH?=
 =?utf-8?B?QjU2ekpXWldXaVlyU1dZM25vNjhIWThGUXU4TlY3UGEyb1RGK0xVdmh2Vkx0?=
 =?utf-8?B?NjM3Z2d5TkdQdW92emJGTjBBQTNCV2ZpK3RxckdzOUN5YzNDeWpidzN6SHlJ?=
 =?utf-8?B?ckZPNlp0THlTdm9EQnRickNYdWpRRkVKVzEzS1VuUmxQY3BlWE9TYkp4TDla?=
 =?utf-8?B?QWhnc1ViclNDb2RJYVV3ZGFudm5jeWNYcmc0VktqZXhZdHZlZUNkOUFDVkNm?=
 =?utf-8?B?ZmtuenVjTElSSWhqdFl5U1JXcStoUktZOTR1RDJoWk1uUURQa0grRE0yMnIz?=
 =?utf-8?B?UUZubVhWQWRwTVVqRzVnY3ltemNYekl5NVg2WjRyYnhqNVZMdTQrNGhiK0x4?=
 =?utf-8?B?ai8xeGhwc2UwZ3lPNlZIUlYvSmUxSm9qanRGaFRCVEhLTXZhMTFuUHNDbC9B?=
 =?utf-8?B?bmNwNFRGQXdxcFgrQW1KOHUrSmlob1dXS0gxR21iVEZMTkpiTnMwbWtPMmJC?=
 =?utf-8?B?aHFRZkNjQW9PK3lnazJsM2l2VWkyOG8reGsxbWtPc3hlMzhuOGtVNFlOQStT?=
 =?utf-8?B?UW01ZkhxUlJPQXgrMyt0a3pIVmJuVkdQMVFJVlFuS2prMURkcVV2aFhaUUs0?=
 =?utf-8?B?RzNWa0cxUEMxVXNMcllnZHhLSjNIWE9neHczY2RkZU0xYWhKd0h4VUoxdWl6?=
 =?utf-8?B?SEJxZEIwR2dseWo1SEhpdnptY1ZKYnAzdUFkR21JZXkxditFVzB6d0RyMXF3?=
 =?utf-8?B?VW9mRDJUQUVVNWJ6d0pqa0REcXh4ZGZsK2NHc2RYTDJQektQblZMbWNhTGND?=
 =?utf-8?B?MElsbHlRU1BEQW5jaGdaaWtUTVhQdUh0T1poZnovSmRWeVNDQlFFQWUxSTI3?=
 =?utf-8?B?Q1MzaFdxMkNRODFFd2QwemwvczYyYXhLTHpnczg1WTdSOHJ6T0FLL0tMLy9y?=
 =?utf-8?B?bTA0TFZBK3NQNGhpQzIwTS9VenJqSk0ybHdIOXdmWHdBMlV6SytYREQ5aEZW?=
 =?utf-8?B?anV0NHEzNlFDelZKMmtWdnJGZEd4N2JZckxvQVE1SzQ3QUNkWXE4cjRjMFVS?=
 =?utf-8?B?UGJ1SDZOcHpsTzNVWDgxMTBVOGV0R0tLRXp2aWlRNUlJdVBuakhHZ2U4bVNh?=
 =?utf-8?B?TW5jM2dhblBUcExKMnBDQzVaUVg2eHFMc3l6UmphbGdBbzVvcTNUb1p4UEZN?=
 =?utf-8?B?aXJIOXhFQXZoNjhObjQ4NjRqVUgvSVVwUURSY2pJc3NqcHMvSzhPQ2YxWjdZ?=
 =?utf-8?B?NnlHNDlRNXVmQjNnWGlSMTU1NUJUeFBvOEJwWEJDMExBRkhlZTRzZ2t2b2lU?=
 =?utf-8?B?S0wwdnNYNHFuTDJiSG9ENzFKVSt3ZU55R0xHY2I1S25CNm1BT3haS3hrcDBL?=
 =?utf-8?B?Qm5aNEtHd2pQeGpIcVMxQlNPUDFMVmNtdlBQMFowbHNLbFluSEJiT1BMSXdv?=
 =?utf-8?B?R2Y5ZFo2WDc1S0d4ZWdubXBVZkdTTkwyNFkzeEM3d090NXdWZ3R2UmE3MktG?=
 =?utf-8?B?UkxwdDZuY05JT0NicHFZaWN5aTB0Z3hza1RzK0FYUks3Q1lUekkvNGU1bGNj?=
 =?utf-8?B?UFJnSGtrVExkdlJWNGFHOGJTMnNwNy9GUW1rVEdkN1pmTVVZRzA0eUNTME5j?=
 =?utf-8?B?NzBON25BSFl6Ry9Qd1NwT2R3cmlUNk5SMGtPWVpmNzZHWnhRRDRNbWNqeDBs?=
 =?utf-8?B?czhFeE9PdHhaaDlVbGJyUVZOOEYzcU9TN3RlQjBJamoxTG5waTNkdURIeGlz?=
 =?utf-8?B?bVlCNnh6N1hkbUJRanpsUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f22c09e-d4ac-406d-8d99-08d8c872cada
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 18:37:42.9586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfST7TqgmFcBNGWMDeaWf/qUTk5ToTkW55GbC4EDiVpaTjJP42XdasZ7q36sd7pXH033Oj9jZjyCnOsBkuVNYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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

Doesn't this break the ABI?

Am 2021-02-03 um 1:22 p.m. schrieb Kent Russell:
> Add a new helper function for printing Topology values to support
> printing 64-bit hex values. Use this for unique_id to ensure that the
> unique_id in KFD's topology matches the one in amdgpu's sysfs pool.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index a3fc23873819..4e4f651dcb88 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -217,6 +217,8 @@ struct kfd_topology_device *kfd_create_topology_device(
>  		sysfs_show_gen_prop(buffer, offs, "%s %u\n", name, value)
>  #define sysfs_show_64bit_prop(buffer, offs, name, value) \
>  		sysfs_show_gen_prop(buffer, offs, "%s %llu\n", name, value)
> +#define sysfs_show_64bit_hex_prop(buffer, offs, name, value) \
> +		sysfs_show_gen_prop(buffer, offs, "%s %llx\n", name, value)
>  #define sysfs_show_32bit_val(buffer, offs, value) \
>  		sysfs_show_gen_prop(buffer, offs, "%u\n", value)
>  #define sysfs_show_str_val(buffer, offs, value) \
> @@ -497,7 +499,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>  			      dev->node_props.num_sdma_queues_per_engine);
>  	sysfs_show_32bit_prop(buffer, offs, "num_cp_queues",
>  			      dev->node_props.num_cp_queues);
> -	sysfs_show_64bit_prop(buffer, offs, "unique_id",
> +	sysfs_show_64bit_hex_prop(buffer, offs, "unique_id",
>  			      dev->node_props.unique_id);
>  
>  	if (dev->gpu) {
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
