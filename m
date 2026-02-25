Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32308EFD205
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 08:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF5110E6D9;
	Wed, 25 Feb 2026 08:01:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cvuV842+";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 079F710E6D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 08:01:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMrz6DMGjRIXkMs7PSb849HH48jVdhLt53JU5b5ShSGq+4zo22bggeOIGKjZfkawOCrCgsptpg0ZwH8ogJLrBQbazC8kEsdHvuUsKPcvDYfKrdjHuRaPlYvDHPBPiv0u/YolSDQVA4TxEOlxAuZQleT9aMZU2wBMiPtHFNnSLnQSU8HFit6QNCnr0TFOTvde15E7dh03ysHPcRS3sd/WgSLEVksm6H9ebSC+SVKJErcSm7mQK4Ah3Jm1rhumGQNeEbD+WmHLXV3EHVsMuJbjuqoYuznHiHu0hpu0tWr5dv4/KxJtPI5x+jkqp6GC3zN/rt7VfWWX30+bKJ/ghMNfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJvX/z8CiEfCw7Ca+VmTvQjT6yZoQtW9ztXl/NYPS+o=;
 b=P9XikIGc6JS8W8Vq3H7KwLPLue845fI00v02XsXaUf51sn1YC6xnuPu7MqOd8XDRUF4Lkvkoo7SKIhYFRA/75yfG4R/u8H6DqZW8PZB2MAdi6fGdNI/u8TuycotkZqPRP2lsWO/apHNuqFr/JGsllTCCyJ5iqS69lP1g7BAZlLnG9AzB4tnyfUzHylLCFaod9uqFjnFk2q++/l8TfhBx/9z8BmwkrInPuDT2ieU3HrYLm3p58G6KGTOeL1bBlzjbdIkRiwTl8xWq6Krnd8D08OH+nLufXYSsLqgSLbZnLA6FZ7MDMShzzK7xtZy6B6sLBNffNLCtTBIuL9Zn2cqKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJvX/z8CiEfCw7Ca+VmTvQjT6yZoQtW9ztXl/NYPS+o=;
 b=cvuV842+NWqcUlLohosAXixb6YitQ2ojY1HJMybVa94/DSfzuDoEOKIUvaDHNVn8nhq9+i3TwvPf4pm492JJdd8CONWsbW4QC9kTm9K/Bc9rVg1kXiK85eOehCjU8qIMn7HxNSDM7vpvZtBypgZi9OVxIt1Cuu41OPEOdsgAQ2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 08:01:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 08:01:23 +0000
Message-ID: <ee6a71c9-aea9-4bed-b96d-782247db2775@amd.com>
Date: Wed, 25 Feb 2026 09:01:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix incorrect max handle limit in userq wait
 ioctl
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260225072050.1640920-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260225072050.1640920-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ff6ed1-170b-4ed2-adec-08de74441120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUlEYUR6ampDbWdoOEpQeXFwU1paUUwyZFJZNVdwT3NXMzNyTDN1WkZJdnBC?=
 =?utf-8?B?R0JSaHlXdksxYjluL3N3SENoR2ZJaDlUZGRzYzNNMU5TSklCdDNwUUNObFht?=
 =?utf-8?B?ZmpvNzBPeWdWSlkwbWRhcWJGdDdSRzBQOXZoVmVKWTZDSnJ3UGs5anN0cXdy?=
 =?utf-8?B?VDhjNHo4YWhka0RjZVRoemdEK0luWU9Xc2ZldXB5OXYxeUZtVHR4VGZ4eWJo?=
 =?utf-8?B?Q2pOOVY4Q2NsbjBaNmJOS0FndE9GNlF2SmZRZ2lSVktFQzJNQk9qVXBRa2F3?=
 =?utf-8?B?a1Z1dWY0bGQvRmtkSHlWNkJHSTQxcll5amppUHUrVnVuT2VPdTF4Q0hScHdM?=
 =?utf-8?B?TDkxbm5td3FDZmJMcGdsM0tGZGZyRlBVMzNGajV0OWZYUkk5dWhyNW1Zc3JU?=
 =?utf-8?B?SGd6TldCOHQvYmQxakNtbkZoQ2VSNHFaK1VKTWJOWFhVaU05OFpXWXRvUFNw?=
 =?utf-8?B?OGdwViswYnN1S2lyRGhNaFRDbDc1NUN6WlphVUU5R2VIRitEVzBBZGQzNU9t?=
 =?utf-8?B?OThHbFZYb2VyQVJ0TExmQjZUYVJqNTM2RnZzc21hR1ZtN1RWWFNQY1o4YmVl?=
 =?utf-8?B?amRzd0duSmN1NUpHZlI5NS9HelRBbWtKNjlxYWl1SE5VeXBLTTEybzhDY1l5?=
 =?utf-8?B?M3hCS1BCV1VFSE9uM2NlUTlST29iaDkyZnUzbGJtTENNZjJRQXdoSCtOWmFQ?=
 =?utf-8?B?MEw4WWp5NXBlQzM3NnlQdjYyVFNTRnVEYWd2YVZ4UnZOdzZONFB1ajZIUlh2?=
 =?utf-8?B?YmlLZmNIS3FPVmhMS1MvcUJoTVJwaXZUcUJob2tyTkVDTlprWVNkYmwwNlRG?=
 =?utf-8?B?bmdwbXhPRHh0ZXBET1F1K2YyMGNVMXVnQ2RHUkNQN2dPNkJET0tXaVp2ZXM4?=
 =?utf-8?B?aVNTKzU5VXJGKzlQdjNpWU5nQlZXTGtnWFJvcEFnc1dFRHdaQm91NFlWR0Zl?=
 =?utf-8?B?a3RIN3h6ZHZqZ3Y4aTJKdXI5OThsVkp2ZnY1SVRQYk1qdXhmdTlCMGk0b3RH?=
 =?utf-8?B?VDFaQzR0aEVGSXBFRzFianhDYU1kMW9hbXJxV05QaTdseXNuNEdlamRVcHJH?=
 =?utf-8?B?ZytjdDFRSGxYL1N1ZmQwa25yR3RVa2JyYXdVMDF6SkVyOVByNEVKOG5rS0xy?=
 =?utf-8?B?SjFWTlR4NzBhZGtONUFST2pmeHpySkFCdFZ3K0FjUzJ3R3IzcEFEbVBZNGZz?=
 =?utf-8?B?NExtY3pRTTRPcE9JSkdWZ2YreHBZU3BKdkcwakhvQkVlbmYzRERwaENtd1Rn?=
 =?utf-8?B?T0xwdDV2QnUwZ0tMUmIvL291LzJGd1Q0c2ZNREFoTHJUbEtrT3pXRGVKbkVW?=
 =?utf-8?B?UVZTOVNNVHlEd1lHYnRHcERuMWtMZmxLVG82OTBRU1h4Wll4RktsazlzT25S?=
 =?utf-8?B?TVlrc2xKL3QzNWFaeEJMUkh1allLYk9ZNDY2QThsSmo5QzVKQ1pNbUNpbFNM?=
 =?utf-8?B?SzZTalp1cUgrTUVabGdpRHJFbzY1RmFHa2pjYVlDc1BIbjZHNWIvWE1lZUlj?=
 =?utf-8?B?WnROWDRaOFFRREZXK3BNcEM4S3dsREZIbmFJMzUyVU1IVUUvSXJiRUR2YTFK?=
 =?utf-8?B?ZWtpaXArbXZiajVRZzZjaTJQS015ZkExQUwrSHlNbzByeVU5WmZOaTFxclBZ?=
 =?utf-8?B?aTZWZDFMQmNxMDE0ZGsxNC9IREYxRVJoMHBlYXVlYkVGdWxFNHhKSUdwQUI3?=
 =?utf-8?B?NHl4d0dSaVVjcXA1OWdIOWRSTjBvOS83VUgyWWdLUFRsNy8rbjQ1dnVqc1U0?=
 =?utf-8?B?MElvbjdDNmZkNnBydkYwdWlHekwxRjFXYStOQmcxckVvZjZZSFJzT01IbU9u?=
 =?utf-8?B?dWVDYmJhL2RWZWg5am5SVlgycDhQMHdES0QxN3JBdmNTY0ZLVUlLMWhrN2RU?=
 =?utf-8?B?aEdBaHo3VzJVTTc3ZXpIRjBoVUxYY2JucXdCcStWazNBakdVNTliVnloVFB3?=
 =?utf-8?B?cHNYc25OTDdkN3RlV1JEWG5FeFVvYUZ2TWRLR2FnYVBjeDNidGxCWGRjdTNl?=
 =?utf-8?B?OU5PajdERjM5RjN2TjhCdTJ4amN6b0wyWFZ6MVpEdGJTeTVrV0Y2WWJWMnlv?=
 =?utf-8?B?Y2RYWm1qRks2a2hJMVhnclpmT05KblRBU0ZIdU5SWS9LVzFzZ3kwYzJWTXV0?=
 =?utf-8?Q?R38M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk9MWUpwaWR3ajk0U2tBaG9BMndnS3hWSTUrSzFVdUlUak5aRVZtRythUUMw?=
 =?utf-8?B?NkxNTEk3TldsbkJWcXVwcHI0UWsyMWdvUElkUUFqTWNYWlEyblBwTG1kd3Zj?=
 =?utf-8?B?MjVTU1FBbUpTY3NnZ3grT2NHTDF5RkllTElzcmhPeE02WGlSTHJZRjBPT3BJ?=
 =?utf-8?B?Qm5wR3JBcDd0TEd2V1QvaVBWekNEeHVDQkdSYzhJWFpQcGFTRTdhY0xJZ2VC?=
 =?utf-8?B?SDRvNjVFZkJLV2w1MmdINnhNNXNvenIrd2NwQ3ZyZlpIelF6eVpNR1FNeVp6?=
 =?utf-8?B?RkxtQ2MzOEZNclNvSVZGR0lURUc1VTIwcXB2RlM5RFhBQkQzS0M5U0tZdkhp?=
 =?utf-8?B?SklQSVdhWUV3YmRlL084OUdSUDZxN2pFVDVZWm1aTnlwcGdtVnRaSGpTRHVX?=
 =?utf-8?B?UEY3ZEdpWEtKSnQvLzdsUHo1UjVRNDVHMk1rZkFQaC9xdTJweXdnTVJHTDVs?=
 =?utf-8?B?SWNiRlVpeFlheFA2dVNnUmU0UE43c012aE53bU01dWxoZTFjRkhmaFZ5c2pW?=
 =?utf-8?B?MXpaWk1KZjlmTnJHcW1ad0ZvQUlDOE9CUjFLdnV0dlhVWGFURnU5T0d1cmw3?=
 =?utf-8?B?cU1uckFlUDBiemZrN09Ob3FURFVZWVJGb0c3enhrcEhocUFBMjI2V2sxWlBz?=
 =?utf-8?B?WDA1a3FaOUZ5ZkYvUmV6TS8zU1RMMjMrei9LRFFjVmdUN1Mxb25tWndwandJ?=
 =?utf-8?B?cUNCSkNHU0ZFWCtLSE5Xc29IZFdHNnQvVkhtUXZDL2UyN2IxWDBMeDNRRFl3?=
 =?utf-8?B?YlN3bUJsQlhTT2duMW1CVDVjaWYrbDJKN1lyNDBKUFR1ZG9xdER3clBXZys4?=
 =?utf-8?B?aFFmMXQzSnlaR1d3QTRvNEZuQkc5YkxJVkpRVUtjTzFXVUJ2NlNoWEFTSUVX?=
 =?utf-8?B?ZGM2L2RJWUtKdWh5MnRaRWxCak92d2JLbXY4b1FaUFFRdW9iWmZTMUZXWWwv?=
 =?utf-8?B?WlVZRjdRdE1kY3N6TGV3QXR2d0V6TDdyK2RWYXpyc1BNRTBmazE2ZGUxeGNl?=
 =?utf-8?B?bmc5YzNodGoxdnVrVUdIY3pFVFc4d2tDaXk3WWw4OWM1TjMrencyRi85UENJ?=
 =?utf-8?B?LzNQYlRYcTRrNkZiWUdibmw2MXZYNkRSNVY2ZnhsampNNzlvdFRGcG1BWUFB?=
 =?utf-8?B?TVV0YWVGWnc4NUFCTXpXcTRzaWh3RU1JVEJ4andjNnVzd1o4c1l5RDhOYkhK?=
 =?utf-8?B?T0l0WGRSM2lCUUtWck55aGtjdmZGU003bk9hMWlBMEhlVDRUYkUzcVNDSHZx?=
 =?utf-8?B?VXJoVGd1SkpkYmJDN2NCdFdUMnlRN3lYZmRRVVpRcDArL1NqM3hMaFlMMEpo?=
 =?utf-8?B?WDJmTngyR1JiLzd4MTAxUDcyWFpyV2s0KzcwUGp1OXVhMlVhSnRhZllyV0dN?=
 =?utf-8?B?UkQyaXdoOHZQL3ZwQy9lUUhEWkhUY1Qrb2k1bGVHeWlCYnIrNnN1dVVwQXJi?=
 =?utf-8?B?Qml0aFRmZjJpczNRdkdESERuNTJSaXphN05hMmJHcEFTN1pINTVORTVwRWlZ?=
 =?utf-8?B?NEx2YVBEK2tjZmlvMGdiRXZrbUl0bFdpUkZ2V3NHRUx4ZTRaMGxhMlZxbFdM?=
 =?utf-8?B?K3U5cjI5NHhmKzFMdit2ZDdtazFkQ1IzWDRleDN3eVRwblkzNzZRNEw3WU1J?=
 =?utf-8?B?NkZmaldiT2hDWmJmNnJXRVo0QVc5OVlqQVhhK0lwWDIxWWw4eFdnSlB1dEo4?=
 =?utf-8?B?OG9KK0cwMjVQbm5TSkIvak9xMEo0TUpvbnh4VzhXc0VsMVh1Z05UNHJBaG53?=
 =?utf-8?B?c01ncml3dFdXMnhBblhKL0pzNHhXdjROYlJEeTNDUHJPZXE3Wk9vUkI2Q0c4?=
 =?utf-8?B?WWZMTlBHZ1ppZ2pvZEYwN2gxbUFneTd1elNtVzdzWnRTSEhxY2RKcTl0NVEr?=
 =?utf-8?B?M2VUZVdWdW5mZVMza1BGY3ZVT3A2QUx0M1ZkVmhVSGxEWDFHZ3htRm5sQW9Q?=
 =?utf-8?B?T0txc1BKV0VlZHZmeDJRb0JHVCtnSTNSYjNzMTNBaHRncTNQc3pUSlhOUjVO?=
 =?utf-8?B?djZmN2NIY3N2N3p0TWpTQkxUeVcvYUFzOER1RlNtK2poVFU5b2syN1BWZWRs?=
 =?utf-8?B?MEl2T2dxR1Q5NzJlZW9sZ0E3NzdleGZqNDJNelFhbkJjZnZSc0YvMlloYmRY?=
 =?utf-8?B?RjNnWjFDRVhaT0x0MXJWVER3Zytrbm1uajZreFZRR2RZcGNuL3RPN1ZIRzd0?=
 =?utf-8?B?M0REdUpHUStvbjlXVmFkVTFLMDdvcGl0a3lBcmYzVXVUT0VyZi9QMXFHRm9s?=
 =?utf-8?B?QjZiWEVtbGVFL1d4L1R6eXBsdDAzcnpmSDNxaGorbTVTQjViUHl0Zk1jMkJR?=
 =?utf-8?Q?6trqlPnkI8TMDIERxF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ff6ed1-170b-4ed2-adec-08de74441120
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:01:22.9943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: es03qAug7qLUq9yH+Me5e7pn1eaI36WsTVK3tE0A7Pc6T1l+/C18T7grX9CFRM41
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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



On 2/25/26 08:20, Srinivasan Shanmugam wrote:
> Clang reports that a comparison in amdgpu_userq_wait_ioctl()
> is always false.
> 
> The field num_syncobj_timeline_handles is defined as __u16.
> A __u16 value can only go up to 65535.
> 
> But AMDGPU_USERQ_MAX_HANDLES was defined as 65536.
> So the check comparing the field with this limit could
> never be true.
> 
> Change the limit to U16_MAX (65535) to match the field type.
> 
> Fixes the below:
> amdgpu_userq_fence.c:642:46: warning: result of comparison of constant 65536 with expression of type '__u16' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]

Well that means that we actually don't need this check.

Adjusting the value just works around the problem.

Regards,
Christian.

>             wait_info->num_syncobj_timeline_handles > AMDGPU_USERQ_MAX_HANDLES ||
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 136071172111..e4bca62bcf14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -35,7 +35,7 @@
>  static const struct dma_fence_ops amdgpu_userq_fence_ops;
>  static struct kmem_cache *amdgpu_userq_fence_slab;
>  
> -#define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
> +#define AMDGPU_USERQ_MAX_HANDLES       U16_MAX
>  
>  int amdgpu_userq_fence_slab_init(void)
>  {

