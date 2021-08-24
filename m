Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFC2C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E972960698
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E972960698
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ABDD6E0A1;
	Tue, 24 Aug 2021 17:37:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4319B6E0A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 17:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOHKZMr8yR820IceGSEL788XZ0TkKIUnm9wyDUzssJLadXuJwF1vQtm/HFTfRQ0JQ7ufnlxXvu6neT4AC8xDJZyY4ivmajkqD0lRxcP3wJ29IEEeNeSOAKD0oHHVLAOgd9I8HXZ7lSeq4+ys0cieXTqLXroJlgshomovCp0nYuC8RLnQMtZNVdlhFXDOUSSI1KFu05XU2QZjx0qVyh1T0MRYEorOl4ajptyAWMDLlZHl66zaEBJIInnK2l4cnfQ5b0UKNCiNxBeZSf9WNiQdVo028RY6CuPkWJeaxyHYrIwwUzTpvZpHWqXiKxUQXXXM/UUCOmeRU1umR4rro1kc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcFc3emcRCOCtdnklP7jbVmGXuouv2he70M5x+7g2mQ=;
 b=BsnZG3IE+7eAAPXqfnJgPC9oOHo+F+X4i1XVJQQbt3O3RmhiXD+NXpB0M7aCYGkFhoh/lA5FeGb1hlLEtU87dZavqp+1KDpwhUnSDhQAntqYvQhxLwnRj8Xww0HaCEGPWG7j0FcZB58Kymosy32Bfm3B248Z4fUff1R1v6hgYlLnZOR/nMyr+QfkEn2nzZ8tIXBJ8BJTIgae+IbhxJCgpuCdpOYPjNAdEoguwbBDOmzmDMsYyCqkPGxDK0+JVDCp1W7yuK84afQALOoWDsV0oKsRZd3nPOzOLuKC8kek3AYV6P3wJFj6001isUXURTbuD4kQoUlfItl4ViFatiY7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcFc3emcRCOCtdnklP7jbVmGXuouv2he70M5x+7g2mQ=;
 b=e4zaZAZ2tswX7Uk7Y9yAn2kjwFnz96hgsyNnEOmIIaO97Bxrd0TM/bzYPRr15rSfiFhTbWQSuHOB0H2nfc2oqeJln00QJBKscZGSQj5Dn1M1i2IX3JAz0ENrXV3i7tgcCMj12KcYmF+Kf6vvWWCpjqLFzqS6cHueoye2Mej0NQo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5490.namprd12.prod.outlook.com (2603:10b6:303:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 17:37:48 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e99e:c0a1:4e9d:322f]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e99e:c0a1:4e9d:322f%9]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 17:37:47 +0000
Subject: Re: [PATCH 4/8] drm/amdgpu/display: drop unused variable.
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210824173630.1915457-1-alexander.deucher@amd.com>
 <20210824173630.1915457-2-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <1b967d52-1fc5-5d86-eb1f-aa4c4f68e736@amd.com>
Date: Tue, 24 Aug 2021 13:37:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210824173630.1915457-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::16) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (209.195.106.179) by
 YQXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:14::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 24 Aug 2021 17:37:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c49a3cd9-f1f5-42ef-616b-08d96725e35e
X-MS-TrafficTypeDiagnostic: CO6PR12MB5490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54907E5A11610C712327A12A8CC59@CO6PR12MB5490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:199;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YPhKCVe5fpjiB5HFBWwLQgE+oOcnjNu7PkDknaIdDKcA68RPKl+rp5Y4kIENelnqGvtmqKvCOA8tT9jmzaePnSBT5+vx0KQSMORh5ojAeTv0ed2fLd0Q/78ms2V/+Xcdmxs5Bwwsuc8p8k45r8o+ZEQpgK3Os++G3iySLyuTZLwIor1LSzQN7amyHIZpCvPPawuMS/uXDehd1jjyXHnnCfhqAT/mo5ipfOxKMOX6B9qPAEGXZQgE4Y9iuiG/0WY1YwGT7XGaKnacZVi/zaU7buYcTrGBpx2rzs+6gfzGi3iScFDOriJ8nsjnRRjLAbPZURbgQ6/WMW/FkFJNzhUYN/6WFyoDl+eYDShzWulSsAdmDe7O8pKzVW8k2cXrewQG/qgPjIAaCWhDPi6SiiAEEYrW6IdJoNaT+LryiqpWXdwPmDFjei9GhXrDdVjCDgqHi79aZ7FLJUrJsrbDqSrTpMoDPUUptBHuWBAk0ebSjHF039x2iJMJDpOSe2vbJpcuOD9ZdP+zaAKC/fMhIFKV0r19hznZq0GpdXkiDOI9SS7qpZaJr5qAgze/9rhbPqpRr76iyBtKUcn9eM6uvDNLgf3nd7G8NhnnGS2jRMCTKtTGR6eOo0csKszf5wkSuNeYS55iekWYa2R2dVjkUqYJaDKpntCdMLShlX/IUXtPmFpUBRYw9eYqzU996xuRKFZcqKZiEXt+zNhGM9VuuTxSJYd5sl9s02egHaDcrqOIajroObDpPgtcQoxxN34EZrX0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(956004)(26005)(31686004)(5660300002)(2906002)(186003)(44832011)(83380400001)(508600001)(2616005)(6666004)(4744005)(53546011)(38100700002)(86362001)(6486002)(16576012)(31696002)(66946007)(66556008)(316002)(8936002)(66476007)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTFkL2FiS3hSeUNQanc5UnVjeTZHc0tTUGgxUk5IV0paYXdtRHZnU2NsK20w?=
 =?utf-8?B?TDkzYzhaT3Rvd2dJZ0hhcmtndWZrcmVLOGQzTFg3ZmlSWUVaKzg4TEQyUUg5?=
 =?utf-8?B?Ulh3TGFVcDM2c0d3c1paS2ZPczhjemdoYWpwc2s1cEJpdVVUVy9hbjNCWXNR?=
 =?utf-8?B?cTkwVnh0SFZwcksxVE9uaW50elE5Nms0bnlmRmlnenl4NXR3czBnMkRrenlw?=
 =?utf-8?B?bGFGUmdKcUFCWjlMQ1BwQUZ3Z1o2SllKZXhFeHBzYW1oa1RPTHE1eGlqbzZt?=
 =?utf-8?B?ejUyZlRyc1lkRXFKMlhPV0dROENHZlRzTFhpYjZSM1VnZWd3VGJXOU5teHpx?=
 =?utf-8?B?djE0RHZkM0Z5Z2JoNGtqQmoxMEQrNm43OFhCNG50UkVPYXZxMUl5K0hia3hy?=
 =?utf-8?B?NFd5clZPV2g0MmRnTy8veTloaU9lOVp3cUhqZVRnbTlCeElGdzh0eXJYN0ZL?=
 =?utf-8?B?MHZoRHpJVENhMFRWYWVWeG1PVk9UWFNxVlBEaHBBRTk1UVJRSzlodllzWVp0?=
 =?utf-8?B?WWVSV1llaUM2NENEUkUrZERiMHM3QUdmWWNVMW5tbGxnaGloYUhkK29FcTdH?=
 =?utf-8?B?OXN0Y1A2OFh6YzQ1L3VwM28yZTNQaUhXRlhmQUgwNXVmdDhEem82K2hLSkQz?=
 =?utf-8?B?Y09yMUVvTWJtR1JGbmxaVkZtTzIzYXN1c2NLQTJnTWNUZzVUNnUyVkdCRWJM?=
 =?utf-8?B?blV2Y1p4S1FOQjlqYXhYeTZNYUlzbTdYK2NGOCtOa3VBREhQT3VQMnVDRXor?=
 =?utf-8?B?a2trMHpISXFQRGJrbjgzbTVJdk5ZWEloUFpPbnpGZHFSQSt4czlLZ2JTRjBn?=
 =?utf-8?B?SkVRTUU3azNHK2wvUUxCNmVrdktjU2p5MTJNU3dmcG1CR3FTMWZDSjZZdG1P?=
 =?utf-8?B?cWUyNTFocjN3Ynp4bFpTM0ZnVURzckliZWw5YXV5aTN0Q2xvS0ZCSmxkWUpo?=
 =?utf-8?B?OXVLU1lRODNQOEFTdUR3NjgySlNiZnljM1pmU3ZLTjRJMWQzdDQza3VXSmJm?=
 =?utf-8?B?N01ZZENJY2lreXliV3NteGk1V3NRcTZwREMxWWJET3VEM3lYcU1tNmNxODlq?=
 =?utf-8?B?M0pRb29kZnhqTHJwMkxuSEZtWUJoMko2TTc5anB2eWp0S1FxNnQ5THMyZ3Qz?=
 =?utf-8?B?a0V2TW83UmE5cHc5WXh6OE1VVmF2VGc4bjU1VHUvUTVydGxSUGJUODJjc29s?=
 =?utf-8?B?c091dXRVdVNoOW9KdjkvU1c4bzRpWjlzZkZ2Qi9ZODRoMzBPN2RGaEh0Z3VT?=
 =?utf-8?B?TkdMTUNWV0xhMDFpU1Q3aVpUc1JmQ1gzcDkxdW5JRzAwQ2t4SC8xekRiK2Rl?=
 =?utf-8?B?UE9GeHNvL2tERlE2ZU9iZExXdHNJTHlPRmdCU3Y4aFl1Z2VHNDdvb0lpUmV2?=
 =?utf-8?B?WW1HdlpyS0U1RW1HcGZ2VnZPaTJoY2I2bzFjV25kZ1VUUE1NVFN1bW9Pa2Zu?=
 =?utf-8?B?enYzVGVPMGR5MWozNFpnWXdtdXdDQWFXUXJ6UzJQQTNKQzM1WkpiVWh2YWlD?=
 =?utf-8?B?Q3FzckR6bjVKSGIxZ3QzMlcyTUdabTFoK21ORVRiNjdZcXN1M1BibHZ2cVR0?=
 =?utf-8?B?d3pIUDJEVXRrcitHOW1VUEFQVFlvNE5zRVRIYThIR2JQZUs5T2puZmNWamo1?=
 =?utf-8?B?MTBqVzhMSXFtWk9ZN1ZkaUw2c1YvUjZqWWFINndPbFJqQ0VlcHJ2OEVNMjdP?=
 =?utf-8?B?T29pR3o2L0thV1I3b3RrT0J0UFlhVUNubm12dHZDVUVBZ0NNd0ZvQWFERGpG?=
 =?utf-8?Q?nmz31hk/9ZHIl7QnzZKMxseo/admHIKqRbC81qr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49a3cd9-f1f5-42ef-616b-08d96725e35e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 17:37:47.7243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+abkyldcUkLI2s7oOYzUE9Xa6ARlpw7mvAHRMJjGPkZGYIx1Hu9DBWSOxq81Rk2bqJdcDH07LVoGaWu6XrXlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5490
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

Patches 2 and 4 are
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

On 2021-08-24 1:36 p.m., Alex Deucher wrote:
> Trivial.
> 
> Fixes: 808a662bb3a8 ("drm/amd/display: Add DP 2.0 SST DC Support")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index bdc7d7ebee12..f58d3956f3e2 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -186,9 +186,6 @@ static bool create_links(
>  	int i;
>  	int connectors_num;
>  	struct dc_bios *bios = dc->ctx->dc_bios;
> -#if defined(CONFIG_DRM_AMD_DC_DCN)
> -	int dp_hpo_link_count = 0;
> -#endif
>  
>  	dc->link_count = 0;
>  
> 

