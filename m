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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94FCC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977ED61220
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 977ED61220
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C8FB89DD8;
	Tue, 24 Aug 2021 06:10:27 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E9E589DD8
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 06:10:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItXHX5mGBQRAZnAPwDuPqO2tYEN03XebsZldUEEnbnVNl3oBVlQpK74P2341zyV659lWHNzhxjw3gq0xHxUYe42Vn+ZR7vTUUxF8USyFSvg2FAsy0x1Tv9q/Omsh9g+w9e0zraHfltJQmlC9Ly+Cvq3MWET8i/B8PdwylaqYI7w6Crlc2vtRGWwHZoatXrEtna9VotaNttPohSr0YAxwWXQetiflo/c51/4mzEX1KzvQNuHco9U9zkGNC7K0jPanGxLEJMHzjwWuhwavFe+NGVZjKApnjVOItG5jVHFcpokJw6RtXZzMHTBP+70mQOBOYp6Fdm7uyI3Emk1Q8zaWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqgzewDcB1+vSzg9+fM/1nYNpa68xsN4nAYWY9O+2oY=;
 b=TdkRHXsQOb0khQCBcfDH/lOhjV5kzbDaIBFiFm+9mUrgDNeAjGeVp7F+t3ymeAElbHzYtsyimEirGhAKYoy3CUHkUTDFO0KDr2JNZK650WJSX9i5lXzQ8VgXwbPIhbj7jFkk1xTqGYrcqCOkpLxTxsUTvVjpuCTAc2E5Cz/7tYOmBcRMW9xqDHglPOR6CyLE4UKm3mNUm4AZnPH1EeH4NcgbWPMbNqGmwrNQ9AMWeeKeIeZNZEThvBd4Q4PHk9Fp78aTawAhEWwPNheZGhuRLgYHFYxz7B2awNW7ZiP3Lj4bzW34JtD4+DFlSMXbTcAy1hz7s2NG47WrJZ3iWeTYqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqgzewDcB1+vSzg9+fM/1nYNpa68xsN4nAYWY9O+2oY=;
 b=pRHtPYHQoIXvP+/SjYANI9U9JMQWWQwbednqhI3fY7rnUe3hBM4br3RVPoLBlQoGRwypz5J3u9PnwHy3ExXrnGj4UkHcvYHZkRr+lTePVKSlbldNDQ6dZyJ2zRQk2+68SwCt2H0jXhXQE597yy2JPyeZ+ierizhBkBQIzay0b4o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 06:10:24 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 06:10:24 +0000
Subject: Re: [PATCH 1/5] drm/sched:add new priority level
To: Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, shashank.sharma@amd.com,
 nirmoy.das@amd.com
References: <20210824055510.1189185-1-satyajit.sahu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <66607af7-5310-629f-1851-df4b74cebf7d@amd.com>
Date: Tue, 24 Aug 2021 08:10:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210824055510.1189185-1-satyajit.sahu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR07CA0019.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::32) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR07CA0019.eurprd07.prod.outlook.com (2603:10a6:208:ac::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.12 via Frontend Transport; Tue, 24 Aug 2021 06:10:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 561978c5-63d6-475a-96a2-08d966c5dc97
X-MS-TrafficTypeDiagnostic: BL0PR12MB4913:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4913C48A2CD0931C6CE251D383C59@BL0PR12MB4913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lfrUsTpqw0NGl8abpMu+aHoX4XGpHcnh2Hs+3QSWGGuyRFCVDO9QianMwX2oV/ZpwIeNWfM7n7ypPGR7PhKgr+i+fkXHcnTpzR9kNfTaVhwVxGkqcY7BlKsJdq7i9t+XIvOYuC/Kvl9z3ozuGsb9JGgZPo8E5IXtT7znZMNFbknfQiupAonvPt1aV8D5DvVLE5ULynxqfM2shEdizFkaEBEa38OjCKMK1sr6pGOisKjh4JhpuEZkboEEgXvyWga+i/cTISLzAReM176JIgtb0i97poxJMG4QFfCwhe69XIP/NVy7qplrPOemka1tDquxZ2yyAek2Ed99sETexwc3W9HOiz3qsrccUiuf27aqkJLGvAwzfkZmVFeANPVTPKWj3bMqcB8RBHoFfXz0OURRGCg4hWR8CdnWqszjdsyyqSzC38yx30OD/Ag2PHDcmXURP8y4kzs6dlO5yRbBXyJoqk9NKeRRQRELmzOGqV6QRTVhu4nmWQLYdmXIyPwftJvmVG35lVQpuiVIGK/BKgIa4nTUtP30IMtKnOzy6Z2KSyPG76x+ZUcT+07wBXns92JdpvqGBiMLQG+gVoGk514H0S8b2yMiYAOvqm1v0ytwxkM55yLHHqu98G3or5yCSVtXZuds38eWO33eh5dXRFlDajbvbnBZUoVTreNOVimw5XivadEfnV0TpV6PPjAC0VX2ngc2a2dpNyaTfE54tiKUZvbRSnAhq4GUKngqhh12KRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(36756003)(31686004)(186003)(86362001)(6666004)(4326008)(16576012)(316002)(31696002)(508600001)(8676002)(5660300002)(38100700002)(6486002)(66946007)(66476007)(2906002)(66556008)(2616005)(956004)(8936002)(4744005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTJwQm1MT0N0THZWbU85LzBBUGxDVWNFcW1UNGF5SWVnK2JxRXVNZWhYVWwx?=
 =?utf-8?B?Q0hrL0R2ekZRWDZVb0JNMWZnd1A1WitFZTNjSzdxb2FYNzhBOS90M0dOSXJQ?=
 =?utf-8?B?UlV1UVZTUW41TVVnRkVvT2MraTdDak9YaVBjaDZjV251NVFYVGJGeWoxdFVD?=
 =?utf-8?B?eS8zd3ppMHpNTjdTMTJCNE1RdlFDYjZXcGhZdVhmdWdnWGtXKzltZEczZkdk?=
 =?utf-8?B?VDAvMnpwSnhkdG9VaFV1bzNGRFkybUFCSFpTeTBTeFowOEtXVHhGdzRLTWRP?=
 =?utf-8?B?cVVZamZkYUZvVkZxbFNJVDZHWHZoV2pJanBIUGlFUXIxNDJ4MDBLNXJ2d2l1?=
 =?utf-8?B?TGV1QWJOb1RjeGd5MWV0ekNhY0M2dVFUUHk1QS9yRmpFbUpmYzJxTVVRZnM5?=
 =?utf-8?B?L3VZU0RZM0NjSTRPcmhwcGY4Q0xuYVBNbU95WmlYdWFZNTRTUWl5TWVKUFEw?=
 =?utf-8?B?dVMxajJ1RlhDM2hEYkUrZHRNRnp4MGtoeGpMOExBb0xhQ3ZMVFZ1NmdxcjBz?=
 =?utf-8?B?SEs3S256VXVidWh4SkhXZHFqZmZmL0Myd0I5RzNWMDR5dEZlYUF1T2ZaVGVQ?=
 =?utf-8?B?T0VUNVRvemRPY3l3ZU9GWnhqQ0c0MTJRVFp4UjBYL2wwbURQSTBXMmZ3d25m?=
 =?utf-8?B?aGhkQlhCZGVESDRLT0tzQkVqaSt5aUpObmxrK2E0OE9BenVMMjdGcEpBdFow?=
 =?utf-8?B?NHVpcGVCOFpOUTMvbFhaSnR4bTBQT1FHNjNLZEdma2UzM3A1QXQ1LzcyQkFO?=
 =?utf-8?B?aGtOR0pTTE9LRDZoVVVxZWFhYkdUUVl6QnoxRlRZL0lTYi9UUFRaTGt5L1ZX?=
 =?utf-8?B?MmhlZzR6VXZMeUtGV2xiQnBDc1FvTkdNajhkNWRGWkR2anJyVFJyY29mWmg3?=
 =?utf-8?B?WlZycCs1YXovV2doMGQyL2VFZyt6ZnB0VWtidVlZOEVPYWt5eVJxdldVWW54?=
 =?utf-8?B?VzU3NXNkYXg1UWw2QmU2NkRMSmFiQTRNVWxtZVhaaVJ1MTMxRURoSWhUTTF0?=
 =?utf-8?B?ckhqUVNZRTBVSXBtcWFQQURTcGFyQ25nMVk1V01aRVhMSEFXWGEzMnd6cld0?=
 =?utf-8?B?QU1Dd0RwaElXL0ZSbVN1WWM0YkpJNHNSM0lCcE9mUGFtdmRWTHJXNWFJazJp?=
 =?utf-8?B?My9DVnY1ZWczZFRKVExQQThKMTVYNjJDSGJZVzFYNWVPbG1Oc2wzeGJuY1N4?=
 =?utf-8?B?TE5rVkorTFZXb1ozemY1R1Fza3g3aXdYeUE1SEgrcG94QXdBamVPRVg3bWIv?=
 =?utf-8?B?Vk90QWNLNWFRcCsvbG9Wbnkva3g4ZU9Dcnh1L2RHZG1RYTZPK2VDc1pLZXFo?=
 =?utf-8?B?dXJLVzlaR2lwSVJrSExrTXlSa3lrc000bzBVcmkzVXYrcEd4cldNWGdGZTkz?=
 =?utf-8?B?SkZ0ekgzNWZJTGY5UGROVFBGY3V2VHpLRk1RUTg5Nldnd2J5cjhINDY1MHVh?=
 =?utf-8?B?bDB5KzdnNHRIMFhqL2lFWHVtWnJWbzArZERoRENVNUU1UWNyUjIwSm9DckJD?=
 =?utf-8?B?Mmx5ZWI0Zlh0cC9RZmE2VTlmYVFGSzh0WWl5K2ZHb3BObGNobTJnamhLVE9E?=
 =?utf-8?B?eVFaTTdacVN5bWIzMFNQWllQU3JyU2dDRGpCUGNoTFVyek5ZSnBDd0l4OWdD?=
 =?utf-8?B?eTdWVzY4SCt4N29iSTgwNmRIT3E5QTZ4c0ViWVUya2k4WWMzTHU3Tm53eXQ2?=
 =?utf-8?B?eXM5TlMyMm5RWjZQdGFuemNjTGs3ZENidWg1Y0RWWFd0cjRjT0lpMnRwSkdz?=
 =?utf-8?Q?iJTWz5SssO/w5tpQPVFSKSJ8dq3+f6vNJQEJTHj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561978c5-63d6-475a-96a2-08d966c5dc97
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 06:10:24.7646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlueKnosl1JDwav4AxiRwiK0/RXxWNQS03CLS3N87kixkTAwu1u5WnMu5ZpC/RYQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
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

I haven't followed the previous discussion, but that looks like this 
change is based on a misunderstanding.

Those here are the software priorities used in the scheduler, but what 
you are working on are the hardware priorities.

That are two completely different things which we shouldn't mix up.

Regards,
Christian.

Am 24.08.21 um 07:55 schrieb Satyajit Sahu:
> Adding a new priority level DRM_SCHED_PRIORITY_VERY_HIGH
>
> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
> ---
>   include/drm/gpu_scheduler.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index d18af49fd009..d0e5e234da5f 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -40,6 +40,7 @@ enum drm_sched_priority {
>   	DRM_SCHED_PRIORITY_MIN,
>   	DRM_SCHED_PRIORITY_NORMAL,
>   	DRM_SCHED_PRIORITY_HIGH,
> +	DRM_SCHED_PRIORITY_VERY_HIGH,
>   	DRM_SCHED_PRIORITY_KERNEL,
>   
>   	DRM_SCHED_PRIORITY_COUNT,

