Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BCDC3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 05:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FA8410E63D;
	Thu,  1 Aug 2024 05:22:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ioz1EGG3";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A8510E63D
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 05:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWWbU6N2btIA7LXSrkyckgGPJ08yPx9nEtNIgUPP6WFkX1CPx3Vol0zg7Xzp2O/D0lOMxeqKfgoY0TzuafBayomsR4k5xqGDmkAjxGWDXQ90VEoWXYXI1tYc2CJcpN1/inDmCPfvxEQyylltMkfTHiH/CxVf0rqhdPWVBciwEtsqCcddP2lVdaXGW4ns1hNT3LHc3AabmHxoT2QPkFH6mbt/ORuZumnq1VqIqcfTmQSkGxAR1KBEsIWkTUNT975VX+0gCKLPWjSlyynCOJJAIPC43sRhkFJ7Af9K8fLkSYayOScFO/FV5Ywo+BjHm161HI6B4nL1jWVVBHb7nDonJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlVVXj7w2QSjR5485FhF1WR30skGfHKC0sfTwvoum3w=;
 b=tLdmS2EyyJMGTvwPsrvNJ2J1bgE0y/9KY9Wh7+5CQhpL2vwJPQex9Yhf8hgEgd4mZJcnJYyV0CcpsaMG+zxgTjZMLNsDNsIovAXPlruQ56vOshgYch013np+qWxoMbeWCjC0jEwKFwZMQY7GpsXkibfaYOLq9jWzhwJxb6zKHZ47fFZ5JXhIGorHucOnHJimdxEz2vMz+R5naB65nULDC8PAtFKmcNanA8Hv7IiUJd7SGJqLHv7zhDifYtJuNw7rqTMtlzLhSX1x/ZSbfyN0g7xl1+cBys4S7ZSX4DJWiULqOMvZAbP2j9cCeoy13nIPpuZEfhF8TD0hDGVoJqiMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlVVXj7w2QSjR5485FhF1WR30skGfHKC0sfTwvoum3w=;
 b=ioz1EGG3gRx3qdSl+RXjqQeikcwaqOXW/wT7ziI5PJZV+2PC56pXa+eW4QDFHGMAzVmKCfPQtfMvBFlfKqUBCy9JR3X0g3zSoO0JhU1eLUdJumscs4m803rXTQHfQ/MB3Mml+lKXCKTtPRYZi5C7HbPpDtNAP8NWNxvqJQjyv6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 05:22:11 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 05:22:11 +0000
Message-ID: <6c201214-302f-45b9-b5f6-064c4840ec57@amd.com>
Date: Thu, 1 Aug 2024 13:22:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amd/display: Add NULL check for function pointer
 in dcn32_set_output_transfer_func
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240731075733.1025866-1-srinivasan.shanmugam@amd.com>
 <20240731075733.1025866-2-srinivasan.shanmugam@amd.com>
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240731075733.1025866-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0162.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::17) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: a98d8de5-9f87-4b77-a427-08dcb1e9e55d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUN3QXI0WGR3Nk5UckRjQkZ5QWkxa0lJYWdBbHF5QzhWQy93NDBtVmY2OE1O?=
 =?utf-8?B?NEtqRzUvZlJyUmdrdmxidkdYNjFHNWRUY2dNK1dibVRJRHIyc2FkNlV6bW8x?=
 =?utf-8?B?YU9oMUMvaCtpckZvdFpCc3Y1QVFyWFJHRjAwNjlMeXQ4N0pZckJESjV2cWd3?=
 =?utf-8?B?d0hKaG9RZENieUpXb3FuRG5qWUlkWG9xRlpYSUlGMW9mWWFYMkFCQjNITitl?=
 =?utf-8?B?VU5xdUNScjRzc0hTbjE2dnB0SW1iOUt5bGdseUZYWTNhZlhzMEROTDhjUVo1?=
 =?utf-8?B?c0VQZWJXZjZUY3FoNGVMZ0w1N2Z1OGxxRnU3bUdiZTRFUUpydG5jNDZSeHE1?=
 =?utf-8?B?aTFNVXFISmplRm84M1BqUzIzUkpxbzd4SGs3RzlCdFdmMEU0Q2F0LzNEMlQ3?=
 =?utf-8?B?ZFZtdGwzUEN0enBvKzZ6c3JMaFBxUTFXMS9ycDhBVlF2TVpEeSszUkhyTkw5?=
 =?utf-8?B?LzZxMlBDYWUrcVg3TC9IWlVBUURNUmk5aXFYc0hpbzhHck5KVVRlMy9jMHNU?=
 =?utf-8?B?cUFRM3pFejlHdDRid09TM2lrSUtlU0VWUmozVGpvdWp3WGVydkk4S0I5UnVL?=
 =?utf-8?B?NVVEeWZOMkowYUdLaVVoazJMTW94ZzBRVzVFZHdkbDUxSE5PVlM3SVY5bnIx?=
 =?utf-8?B?ZnVSVVV0TVROV3Z1SlkybElIQmsvRFFIT0pYc3VGWEladlZWREpFTUdMZzJJ?=
 =?utf-8?B?ZGJEM3ZTNDV3blQ0cS9mNzdpVG41WVlBcVE0MWc2KzZwdmozSURyS0xNTTdh?=
 =?utf-8?B?MnNjeDRqVXpCZ0lzek5LbUQ5U2hxUjEzZkpyK2xSMWRkZHFTMlNoNWZPdUtG?=
 =?utf-8?B?VzNNbmZCdWc0Ri9UN3l1d1YrOXdERWtnWUNRcnp1WXBiZitFMGEzRmRjVElX?=
 =?utf-8?B?YXk2TEI4eVZ6a3h6amkwalU3MVhMNTFPcWRrV3I0Q09tK0w4WDFJdjlIczBB?=
 =?utf-8?B?dVFLR25ycWVJWVloendIaEdZVDVJZkdWcTRxd0I2K1RTOXdKNWNJUEJsUDhm?=
 =?utf-8?B?MFpncGdlM1lkWEptd1ZocDNacUpGL2tNTHNFdksrQ0luVkQ0d1VsZUp5OHcz?=
 =?utf-8?B?T3NXOC9Pc3VndGdCZXZvWTMwR2hUQUVjb09oT2ZTTkwzTTFOVWlpNlpYVlhz?=
 =?utf-8?B?dnIrOXBjdEl0ejd0UEVudEI2aXB2WVVaQUExem92YnMzWHpmTW83WFRrNCtP?=
 =?utf-8?B?U2tjTlZCZGVtVTI5bHVFWDR3UDBNWHo3d3o3bWpKZUFET1dzeW1aMjRuOEpu?=
 =?utf-8?B?dUZrRlV2RFFJbE9keXJOTHdqTkNJcnhOemFXcjNQa2x0TjRqd2c1RmF2K3RX?=
 =?utf-8?B?U3Y0RDh0YjdreXI3a3pNRnBLVmR5M0FlbGdQL3RnclJxWEJEdzd3dUhlSmNr?=
 =?utf-8?B?MWd4WTUvT2UxVVpLN2F3bzk4VjBIOUxSNWJPcnRyN0dLUEc4Mlh2TklmYm1t?=
 =?utf-8?B?RzNQY0VER2JYMEJMd0Eya1VCSDJOcWNPNnUrQUNpMzZEZlFlQW5hek5SVElX?=
 =?utf-8?B?ZEptVW1tQ2JGYisvWS9HZ3ExalRzbmdiYlpJRStBSFhlS2Z6QUJXYW9HcXRk?=
 =?utf-8?B?U1NYQ0ZNc1EvRmVDdXd0ZDdTT1k3c3cxVldTSUt3bThlbU51ZGt6SG1aS1Zi?=
 =?utf-8?B?UFZYSGwxWUlmQlVyd1QrSi9pVmc2a2dMK05RS01JSVlqdmc0dzdLcG4wZmZj?=
 =?utf-8?B?VGE0enNicjFYWHJDejErVmdyL0hTbFk4QTBWRi9FVTF0dmdabG9sVGVxdHNw?=
 =?utf-8?B?MEhydUw5VTgrWnl0ZnhRVjJTNXExYSszOG4vNjd5ZVhOY05MNHhGMVVJQm1O?=
 =?utf-8?B?OXBQdy9UVEh5ZWU0RDhPZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3pId3B3MTYvS2FGbGUzdUhha1RXa0VpaWRHeVlhL3lrZjFLSlhGZDhKakdp?=
 =?utf-8?B?K25xSFZSVFFMbWpERWd1bjJzdnZCU3RkcnFncHVtemFQMGN4NW1CRVhoSG9T?=
 =?utf-8?B?S0VQVFZPRWFKcFdGc0ZwTHJZaWFrSHNUWlBYTmNmUTd4SE5wWW9OLzJ1dDJo?=
 =?utf-8?B?eVpueVRWK1pLbk1xeGZBM3czWXNReFpVRy8wRHkvOTBnaE4ySGZLbkx5TU0v?=
 =?utf-8?B?UUxSeWdIWTFzektSUUxSaE9jclRIdnVhYUM5RFlOYitZU2UzTGFqRCtCOFp5?=
 =?utf-8?B?Z1lrSXhJL1I3UWE0ajVpRkF0QzlyZmFVK3dzZGJmSGdieU0zRXdPK1NQT1kz?=
 =?utf-8?B?cmJQRG5GMDNKbmpjMDdoZ2pXR29hd0FxVlZMQWpJaW9uZzNQUkVxZTdVcUlx?=
 =?utf-8?B?dVR6L2tmWkxMdzJlbVBPSUpJZ01DSXAyNVRRU0toY0I2Yy9pY3lENTJXWHdW?=
 =?utf-8?B?SG1OcFh6ejVsRittamw2c1ppU3Vyb0dGbzFwT1E4L3RWakV1akUxQkxpZVdI?=
 =?utf-8?B?K3ZiNlhlaUtDeVlYWk1JUDFQUmFXcko5ekhpTmcxZHFsS2NBNVEyWVorcWRh?=
 =?utf-8?B?bEN1cjhwVHRqcEk4WXdwL2M3VTBudXo4MyttcFZkMVRLNFdEeXFpNFZxK1Bz?=
 =?utf-8?B?TlRaMThNVTY4bk9EbzE0Zk95bFNpYmJaOTU0NWxhNzQySWNVRm11cE9CeWk0?=
 =?utf-8?B?bEJuMTJ0elY3djg1anlzUkVnd0JxZWNzVGlNakJBb09Ic2xOYTkzNlpjcHdl?=
 =?utf-8?B?TXhQS3Y3T2JsT3ZJQmJxSnliZ2RPNFVRU3VvV0JjVy9CM3BWRm9KUXF5c3VZ?=
 =?utf-8?B?QkdiUzJvRWN3em9WTW9UZGNiNEdwQnFVeWcxRFNFbHhSMTN6dmlFT1NoNXpv?=
 =?utf-8?B?VFlmbU9zT2EzK0pQQXcwN3AydUlSaDhOSDFHYWV4YVlCZ01tUDdEWTdZWTdV?=
 =?utf-8?B?T25OeHNONWVJWGpONENYOXNlem14YXFkYjN3eTg3TVVvejYxQmtmR0E2MTVu?=
 =?utf-8?B?VDFSdlVUa21lRUFLSEE5U1h0VDhWZWNqMmJTbWRHSlpUQzNVL05YYmlndFNT?=
 =?utf-8?B?TDNpdGY0YTFEWDh5bkFjaWN3cmxiMjlOMmFLcGF6SEw5ODhKeWF6c2g5YVdw?=
 =?utf-8?B?ak5sMWVWWm9uWjJxTktWaHVOK0dURG9LWmNOaGZ2YkUvYld2WjAweWFqR2pv?=
 =?utf-8?B?cUU2eEM3Z1JRdXlKekNmTFo4OTJZVGgrTVFqYy9aZ1dZV09WeDlRS3VYaVpL?=
 =?utf-8?B?MVRvRjlMYWRka0NWUFMzVGVxa3NuSkovUTd1WS9YZUlWSkh3L2R6Ly9VQWl3?=
 =?utf-8?B?R2tGd0kwSVFuNXB2a3lsTGJLZ2hiWUpXZUo1cS9GWmJvUnhoL011Mm9GTUUr?=
 =?utf-8?B?RS9kS2dyaVhiNGtmdjZyeDBSbllyTzI4cHRnc1FhUXJhVHh2aXRVSmhFN1gw?=
 =?utf-8?B?ZmxwU1dGdFFPdytyRTRRUWhwTnl6VStrMDREcVZXWkNsRXNUVlJlMkI3YnFr?=
 =?utf-8?B?VUJNTzVmTjBhaFRvYXpKOHY2TlE0L0pnU3EvS20zbTc2dFpPMTJsdzlnUEFL?=
 =?utf-8?B?SHlXS0VoREZBNGlKZDRlNXFXMmFNSGJ1WHAwV1RZQ3JRWjJQUkd3MGsybCtB?=
 =?utf-8?B?emdmQmVIMFZCbmFSeGZHYTBiSzhWQ3lBcm1Ia1BSL3hmYlErdUJDVitjR2lp?=
 =?utf-8?B?cTFaeWlkYzQyZ2hEQzhEMVhzVEtvUk8vTzI1TmFaajBpSHkzd0M4WXFWRmNi?=
 =?utf-8?B?NGFlbU9NTUNTcXM4NEJFSENsbmZIVDlMWklpVHphU3dTV3ZVRTZ0S3J5QlQr?=
 =?utf-8?B?OHJqZ215b0k1RXFDTmRxek13YVM5N3Y5KzZaRzNWSnNsUjEvdSsxNVpLZndX?=
 =?utf-8?B?dnk2MFNMMG5Uc1dZTjJOSHB6dkFQQTVnZmtaOHBEUGkrYXZuZVlOQWZZTjc4?=
 =?utf-8?B?SFMvYTlEUWViRTVaZkxsWERWeXJod2pxa1FiRUc2MWllRjRrYjFDVloyWFVO?=
 =?utf-8?B?Nmc1WjhWVjZ0ak1sMzZsWHhsU3dwMUtzTzBtSENCcDYzc21OSWJ1ZmpTT3pE?=
 =?utf-8?B?ZzZ5MkkyU05XcnNCMUM3Tk9tOFJWU2tpWkIrc253d3VZVUdoTXNCelU2MXBL?=
 =?utf-8?Q?plOYnBoL9gUr58PB1lF0o5Rn6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98d8de5-9f87-4b77-a427-08dcb1e9e55d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 05:22:11.5127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6FLsYqhSO0BD422J9EnnjeIkSbsrjSMJ8ggvGZY9X4Vq96cpx847KU8nvhGtHnbDw7wflZo7Kteq+h55g1CDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 7/31/2024 3:57 PM, Srinivasan Shanmugam wrote:
> This commit adds a null check for the set_output_gamma function pointer
> in the dcn32_set_output_transfer_func function. Previously,
> set_output_gamma was being checked for null, but then it was being
> dereferenced without any null check. This could lead to a null pointer
> dereference if set_output_gamma is null.
>
> To fix this, we now ensure that set_output_gamma is not null before
> dereferencing it. We do this by adding a null check for set_output_gamma
> before the call to set_output_gamma.
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> index fcaabad204a2..c3bbbfd1be94 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> @@ -582,7 +582,9 @@ bool dcn32_set_output_transfer_func(struct dc *dc,
>   		}
>   	}
>   
> -	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
> +	if (mpc->funcs->set_output_gamma)
> +		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
> +
>   	return ret;
>   }
>   
