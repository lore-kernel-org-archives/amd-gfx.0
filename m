Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EDFC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 12:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC9710E9DA;
	Wed,  1 Jun 2022 12:11:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F143B10E9D7
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 12:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jH+GExGIeuxO6e3lI5VvIbEO1VLnhLPMl4Tz0xvu8jbGm+RthYBRdFHP/jC7Sbc5nnZ7DfRg39W49v6iUt7yLyKJ1N74eC/ITWWYZL/kpQkM3lcOKIbIMm3Jr8u55HOAKfWrEZs3gYaZ0AsOeI629b3tf6+uUQep3+y/ojCAbfCNFRtbyLqg1Vg6uWUeRw3n+uNRuDF8aafafnEN7lsayYSbdFWkPGyEaYURtQ0lZzTN/IDR2jvQ49eTKdXn621lmu3Ap4C5rh1FFa3hpxXRpftzed494gN8q1y80tHx3cAayKk2Spy1Ay5yx2h0xwrUpL0v/KmQfQTUJIpws7YzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuXuYUTK92mwnrdynJxvqj1fuI1Bh/p/v96huRtj3rc=;
 b=XxDST2MGVVRqfkXKD0YFscxfrQ1sdI7iMep21aho/7DjS+ChHZrBrVGEilZe/pQWKWIYN5IJ9UYMFOe4gXF1aXVN7Q3N80oSnxBc/1pI9EXlKRPI8K377+wrKdcVcDCztUsCb2Jcy1Yrxz1IFjEwvq+2goY9/wQjMEwkZBrX8P4QqCMszgQuUAIVOE7r+Ni/FvWhqi21pJsSlVwR2XUqX4+oyhwxhz3hv1tj1yXOu62jLj5uFXk3sbWQOVQ5iuVbPtkBE2FujNj+H6/9Y+UfV5pqrPwQhRyPnCEOv4c1AguxHnnrDJx0FiufhG55bCQHQuI3oix1di5kyHyav+R7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuXuYUTK92mwnrdynJxvqj1fuI1Bh/p/v96huRtj3rc=;
 b=tSevSM00ooF9z91LkobFDRiObDai8s1bVsAg6q3/d+7FRI+j91LHk7Xp/Ht/4CGa+ZReP0nCt0hkzWRA9DGAOoHUZNSt2EdbqWGztzmDqnhUqIgW26j51xnjkhvd9Q52njx0FKLbZE44kvnbnUgtQXay04jsVVN9+as3muJe2gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB3988.namprd12.prod.outlook.com (2603:10b6:a03:1a5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 12:11:51 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 12:11:51 +0000
Message-ID: <04063003-02f6-3ca3-49ba-51406c22d19e@amd.com>
Date: Wed, 1 Jun 2022 14:11:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 10/10] drm/amdgpu: add gang submit frontend
Content-Language: en-US
To: "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Olsak, Marek" <Marek.Olsak@amd.com>
References: <20220303082308.38217-1-christian.koenig@amd.com>
 <20220303082308.38217-11-christian.koenig@amd.com>
 <BL3PR12MB66193C104060707AE4900848FFDF9@BL3PR12MB6619.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <BL3PR12MB66193C104060707AE4900848FFDF9@BL3PR12MB6619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0171.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::26) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 962556fb-de28-4992-4347-08da43c7e8e9
X-MS-TrafficTypeDiagnostic: BY5PR12MB3988:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB39885B83F2725C842A1B263483DF9@BY5PR12MB3988.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLRjlBlQfP4zQwKqphtsFd28hXXZGi6v5pVJL+33Amc7xZLyaz9LnqMa3Tk+4LX5k7Uwg008MS+LY5iX6IpuhVX/TlNOyjWBVuB6xYyFzzoWLp+a/BiJHSP5K6F+2x5LIU7ZzCIzPWZt8CvjcVNsXt9j0zI0TswVhIUBpAiFf02IK6yrON2dPetqV35tpYCCjm6sRTYQFy8GBLB0pXrQHWFgVGhvFisIUWO8FogXmCwshvicQRLL4QGBgt0R+OzPTc/4iZB5Bi7dL6oFSEbAs3FnWWvWu/b4JWUeYAR8ZArO06YCoCmfg3Nx3Cnb58sJfdUwwLI3+E10t+KCYGCeaTXmy8xHX7ZdClC3XLFd3+XQnRN2DK7p9aJT+yM/nq0pMR7lRooPKiR5phmGPYHnbZeLMJqVFOW0pFvGoB1G1OLMi87OqeO/ZPToAaoBXFsNNhrJH08MdIB/CHJyW19yTtwAlVfrX2wnC54tFDOa+hG+qlu9eLRclcNml76lO6gF+p8C/WBw0+z8oObnSqLYTTDIxypsEoGmpyzIxHw8mFx6MhpjhetNu7LXQA8OejgZbHiPHF/9BMdIjcn0Y97B3ki/Gm10VtokUz8ikhSWlNAig1Xtxal3VZTFFd4z6/5b7FeJJNvZr1k/rXOmlNZTb9ZgVmjqNAvCeDK7tlKp+ezquhQpiFBfJ6lLMPJRV1JKmw5h2/G8P75oS4/c3xy1nyLdCR9E+f+H0vhb9kVRdfI3uQebS17EbuJNC22T5vtj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(6506007)(2616005)(6486002)(31696002)(6512007)(26005)(186003)(66946007)(66476007)(8676002)(66556008)(86362001)(110136005)(6636002)(508600001)(316002)(5660300002)(36756003)(38100700002)(4744005)(2906002)(83380400001)(8936002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXozZWRFUnZRYS96TUJCeWlncUg2WDB2dkpJMzVabGFlTERjTGY5ZzlqSWR1?=
 =?utf-8?B?dzVyTGJtS1VXakVqeWxESDd5SG02VUJ0TVpLQy94WkhMRG9CNFRFMWxteTBW?=
 =?utf-8?B?alJDNzN6NGxsZ1NmSXdtcTFqNm96RFNDT0taNWRuaVFKL3JpVjJXUEtuWXBn?=
 =?utf-8?B?THFqNHFRSjNSWk8rYkg0bEFmQUhzOWJ4b0FvRHVnNHZTQjFjS2xrSHl4c0Ja?=
 =?utf-8?B?WWpZQno3eEt2M3JlQWNPQmRVMVdpbkFsMVJHTUsrUmxyUW5xQWN5R2MzdEJj?=
 =?utf-8?B?M1JSNjdWd2pKVTdXRHJKbzNTdFFNMG05NXhzZU1MVEpYQUFoWFc5VUJkQWF2?=
 =?utf-8?B?STVtRktOdE12Q0VVdkI1MC8zR3d3cElja1liYVR2NmlTaDRiTUwvTzRJTDZ6?=
 =?utf-8?B?dGtGSWVSakVtaWRvaWFJa1RBSEs0OEgvbTNSNTFRRHh4RFB4Y0lwSmJNeWNT?=
 =?utf-8?B?T0F5WGk5bnZjL0RrcWFtUDYvZU5ScllOajI3QUFRd2UxU0k5dGErOWU3ZUk2?=
 =?utf-8?B?VFBxTXNaclRweGpHTEwrMjFxTExNdGdWbXhURGtRcitwc2NmQVBoU0dhV3VC?=
 =?utf-8?B?djFnZDMxY1lsUmhDMFBLRUhjNXNDVG5yQjArcU9tZkVxZkFHNUx0bCs2cjV5?=
 =?utf-8?B?R2Z2b0RFTmdVZURJR1Byd21VK0U5OForbElYamNpLyt0cVVOSENRWHJ6RUpD?=
 =?utf-8?B?YkdlMmwveE1hY2xid2pJZWRSWWNaUFRiZm1hcVdWbVVuZnRsWGIxalgyUWNm?=
 =?utf-8?B?L3hWQ3dZYm5VSTFJaXBMWWdDbFBCN3lDeURQMThtYzEwaFYwaXl0VHBHVnUy?=
 =?utf-8?B?bGNSeVdpeFgyWHpBUHVWOFdVT0xrYW9OUnoweHJ3S0ZKa0VZck9ZY3JyaDht?=
 =?utf-8?B?QzJyNEFBNEFqalU3OS9sdlF2dTlXeDY3b0h0SWRYeUo4c3FncitXcDJ1czAv?=
 =?utf-8?B?TVo0QzVQQ0ZmYlhZWDFzM29iRzRoRi9WNXFMZndFcFQzdCtPbGJCaFVyeXM3?=
 =?utf-8?B?YkYxOHJGUmFUbWxabE96cUNWanNiYmdhZmpWNzVVRXlaYzNuQTl6N0Ewd2hw?=
 =?utf-8?B?VklQUWQxQ25ReFlnTTB3MVI0cEM2T1BMQTJHcXhIV082U0QwZHJRcjF1c0Mx?=
 =?utf-8?B?ZkZYUHZaQ2pxaGlDM3hhUFF3bWg0UUh1OU1SU042VFYzaHhkRnM4M0I5SXBX?=
 =?utf-8?B?NlZ5SmRGQnI2U3BOclNUeksxNCtjOVVVRUFKc1VkOUpkZDlFR2hsWFArOTl2?=
 =?utf-8?B?ckx6ZEJHMUU2RTRqZWpBYWZ2MjJVdmpiTHdGWlNyRUxuNHFFUkNiZy9GRVFR?=
 =?utf-8?B?djVIdnFNZS8wNHFLVmJrTU53RTg4Zk5SMldxc3BxMnhvVStqekZ2bHhIbmhx?=
 =?utf-8?B?dmF4TnFWNEZlSjZaZExmeFNCaFg1UVVwcDZyK3M5SWpQRXl6NnFHby9KMWdo?=
 =?utf-8?B?d2dqMkRvcW9hYnJLU0lvZmpJSDZzZGZnZjR5UTE4RCt0RkVVMm1xWHNkR3RP?=
 =?utf-8?B?bUVndlJxeERlZFlLbGNPNjcxVC9IU1hFTDd0VElYd0prY1lXWTh1SHo2amgz?=
 =?utf-8?B?Y2JrbVpIbHl0eHduZkgrNVo0VTYrcWt1cUR6dStFOWk4alZZOVBBb1Z3N0tD?=
 =?utf-8?B?RnhBc2I2NnpHUmxnNW5OQ3R5em9Wb04vNitJMzNqallRYUhVa3EzVXhUWjV1?=
 =?utf-8?B?SXNmWEVKVzRPOG0yWVphbDRvOGxMSGJFbGJDK0pMMktidklyQ2dGeVFvOVFx?=
 =?utf-8?B?cFdGdXp2ZTFOWW1WeE92SE5kWXZvbGdLbEZTV0Jza2hrU2kvKzlYWG5tWjc0?=
 =?utf-8?B?cEl3Sk5UaVBnbEFZVGNiaG12YmZ4NzJhcXZYc0Erd2prK21jUVZBWWloRCtz?=
 =?utf-8?B?QkFLMjJxT0tjRXBaZGFkUTYwUkJlNndoaUdJb3VCSVMrN2lRZkl2SUhwd2s2?=
 =?utf-8?B?V3FnTU5kaG9YZXdjUHloZmlYTHdXM3ljT1J4Q3VBUmMyTDcwWmRjeTVHL1Iz?=
 =?utf-8?B?Q2YxQ0FLQTMvSFgvSGI5aUROWkhpQTRiTVdCNUk3YUZJc0ZrTWFWMEYyODND?=
 =?utf-8?B?ZHR0VVVpNy9GVmlsRGlRdGhPeWNQZXZ3U09oSVp6ODJkazV2eVBLSy9yMlcr?=
 =?utf-8?B?eitDcHNxbVlDbUtsNU83cU5LUGl0YXNnd3N4bWhhQWlaM0d4SDZBcXRYV2tE?=
 =?utf-8?B?aHcrS3l2OGZreFdVNHh1cHpzRmozekxGUVhONHdWUHEyR1B2T2NOUFp3ampz?=
 =?utf-8?B?RDNhSnNIaWNiN2swcEJLbEMvTEFnakdEb1hZejh6TnI0SVNVLyt4NVY4WXZ2?=
 =?utf-8?B?MFJTRkpjZi8yL1A4ZWptbFpISVo0b0R0azEya3hkMjdVZWtnYWs1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962556fb-de28-4992-4347-08da43c7e8e9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 12:11:51.3844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxwFzcRus8hFSBZO3Qwpr1reaEMzVP3zsA1qW6iZsM8c10MMXdN1v2RaR+jN+vEz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3988
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



Am 01.06.22 um 14:09 schrieb Mohan Marimuthu, Yogesh:
> [SNIP]
> -	/* Make sure all BOs are remembered as writers */
> -	amdgpu_bo_list_for_each_entry(e, p->bo_list)
> +	list_for_each_entry(e, &p->validated, tv.head) {
> +
> +		/* Everybody except for the gang leader uses BOOKKEEP */
> +		for (i = 0; i < (p->gang_size - 1); ++i) {
> +			dma_resv_add_fence(e->tv.bo->base.resv,
> +					   &p->jobs[i]->base.s_fence->finished,
> +					   DMA_RESV_USAGE_BOOKKEEP);
> +		}
> +
> +		/* The gang leader as remembered as writer */
>   		e->tv.num_shared = 0;
> +	}
>
>
> p->jobs[i] = NULL is done in previous loop. Now when running &p->jobs[i]->base.s_fence->finished there is NULL pointer crash.

Ah, yes good point. Going to fix that.

Any more comments on this? Did you finished the test cases?

Thanks,
Christian.

