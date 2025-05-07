Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2760CC3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 12:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C76AE10E36E;
	Wed,  7 May 2025 12:49:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u4JjVepU";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB5210E36E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 12:49:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0lnkBBDEUeUkZqCM99HLH0n8rxGHed/LC5frv66gDdWDV8ge6i4SEHtdLWcw5DR2dlyX4QkdPHJtbJhNM4AehiDLt+OslIK8+40x42OLoNafnUKKSe0chXH+ZljjN3ZjwTOorp43V/ygqq5gGmf0n43JLPJ2KCZasbLJr0CtichoGLtdeqTG+B0sxxFiXZjWcbyOsj8DNwwapGQji8STvJIeN5m0UbmsOcAG5JLmIcIWtJteGIkyedL/0IX/EndVVBxppKWVGYDgw0YMJVAGj95CI3Vi2lUJBanNYgL/tzzljEc5kVYa/zSCDNFq7+PdLaxIfW++XHN1nX8G7MwYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01vNttUzthIFny1Jd4KcrFWZ07SG5sza69wEbR/kzXQ=;
 b=AQZ8RmNmFXCbEayNXcmN0xuduOtP8mWo3AULzQKZaw/x0hGRpD9eb5ZXuMNUA2gnslV10hT7xwug87Q/MlJ0t+LyhLXa5/3aE2a0JqWGyCgDFhcO4e5LVOymxsdchHqrAkU5jpsqpynYH2xrpe/upg/ae928AvSpAeJZ8pWnwjuzXnP/KaXTkiKXUftZ6xwLKgLI/jT/VXvacd/NiTkiMruxl4yb0AzbcLpn6VZpQrWHXxuTEQ7BOTUVEssQjAzYAblMrxwNpm7WUVh+PbdMHWBDTVVvuo++mfRa3kH/39F6/QA496AJh91T5ih8ITPEgfe6sOr82+60Twy1DT8Hyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01vNttUzthIFny1Jd4KcrFWZ07SG5sza69wEbR/kzXQ=;
 b=u4JjVepUnQS/vp+HGl+Yj9Cs2ZzIAgFZbbBd/iRWD4wRt7wo34SMrbi/8m5Y3jmapLFDknK9XmskHQJKlzxvfp0IaHBdFoTcnOLCo0wTtZLbpll+29CzcT31yKgQAN+qjt0R67bcjJbrPlERTw8GzNCViBpdXLqHAlTNoPa7QEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Wed, 7 May 2025 12:49:26 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 12:49:26 +0000
Message-ID: <343bba9a-d21d-448b-925b-f7af8237250b@amd.com>
Date: Wed, 7 May 2025 20:49:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id and GMC
 configs on resume
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>,
 "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
 <354d063e-ba67-469f-a945-d8c6467f6c11@amd.com>
 <DM4PR12MB59371DC0E9B611C568CE395CE588A@DM4PR12MB5937.namprd12.prod.outlook.com>
 <5a80dd63-3dab-4117-afd1-b25a2a8d1725@amd.com>
 <13a13f7a-2a6a-42f8-8a06-ebf892bf06f6@amd.com>
 <6b2ede19-a7be-48f0-8098-63e05dd62691@amd.com>
Content-Language: en-US
From: Sam <guoqzhan@amd.com>
In-Reply-To: <6b2ede19-a7be-48f0-8098-63e05dd62691@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0246.apcprd06.prod.outlook.com
 (2603:1096:4:ac::30) To DM4PR12MB5937.namprd12.prod.outlook.com
 (2603:10b6:8:68::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5937:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 01dd530c-681b-44ac-a25f-08dd8d659918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3FXWSt2eVVWMDV5aHFMM0NNQnl2M3hCRWtSTGQ3MitLL2FSYWNPRGZwRFVZ?=
 =?utf-8?B?SlNRYzNnTm93OEFzMjhFZkdxUWxjTENaUUVrbWI0empNeVBJcGQ5aGY1TjFB?=
 =?utf-8?B?OFpXc2UyUXNETG42eUE5RzRnNUtJa2MyK3Y2WS9lL21rVGJuaTJxbVJWaHBH?=
 =?utf-8?B?elJMMEluMkM0NzdFaDhib2c2R29XR3JhZ2k0L1lzWk1TUityME1wcU1CUzg3?=
 =?utf-8?B?ZmMxZ1dHSGJETDZOcGxNNGdmUU1MRThtRmhDWHRXdzZzaUc0MDZKS2dOSFNN?=
 =?utf-8?B?WjhVUWMxTmg3TUlZZi94QmxDcDNzajF5ai9TY2JhVkVOS1hEQkxrQmF0WlFk?=
 =?utf-8?B?R0NCQWdhY3l1RE84dVNBV2hPSVpLWlJoMUY1N1g3U292aHd2cjNGa01iUm1v?=
 =?utf-8?B?R1JCblRpYU5uam5YNWhiU0d4MGtIMnRBVWwvL1BNODhVd1N2MGRsWlJrWGZU?=
 =?utf-8?B?dkVhcC9QbSt1QVBOOWxyeUdza2RBZCtlV1VyVGMvb04zQkhpMHdrNlV4dlJ0?=
 =?utf-8?B?d1JESUNXekFXY1lxMnMwQ3labXg2RHltbis4T25SQ2RXQ05uT1Y3b2pRRmp3?=
 =?utf-8?B?RWQ4TFF4NEZVQzNHekwzdFRTVk04a1NVYXczSHZEanBua0NiQll3Y0h0OUFh?=
 =?utf-8?B?SnpTWjhnNlM3TVR5RVlNWE1HYW8vM2owNHpOSzlSd09EV0ZxN1JwV3YzekQw?=
 =?utf-8?B?TUtJRWwwWlVXWXhnSFFHeGUrWTJWNWlxZFZUcGNJMmlRRUJxeFB4NVQ3MlNz?=
 =?utf-8?B?cS9WMkUwcDhkdU9GTGoyRWRITk9Ia0lsS3ZBRzhPWmt4eFVRdm1jZjNIR0FK?=
 =?utf-8?B?cnN3eEYwd3RidDBBSnAxOHZXRS9pcXJ6bEhuZzk4VWdLS3V4NFdiRkMzeE82?=
 =?utf-8?B?b3laOEQ4TGV3WTdsQ0RJckNVTDlYNWxycXVyZXRHQ2VFWXg1QnMzZjFFVTR0?=
 =?utf-8?B?d3krVUx4Uzg3bk45R0R2dW93dmNWcGE2V3FnZ2MvdXRuY2NHcmgydEIwa0lv?=
 =?utf-8?B?djdMcXVPWWxBSmY3Zyt2RWczcTd2RG9JTHRFTVV0ejVCNVFISTVhWURnNUlE?=
 =?utf-8?B?cmxRd3labzRaajRYOXBpTHZQNGR4bHN1L1Z2V3gyZjhDNTFLUlBkTTZWRTds?=
 =?utf-8?B?ZFl3bUduWFdKMi9NZUMxcTFZQjcySzZDQ2lUZ29DbGVPQ3pWMFUyTDNEMjlx?=
 =?utf-8?B?azlPU0FKRWd3K1hUdnRLL3VUQWhzK1FBa3pQWk1yVFNGMVo1aURRankra1g2?=
 =?utf-8?B?Z3RENkVTMUxRcFpBZnZhSUFUTitYcVNxM2RSaWVLTWdKK1VPeXRVbVVRSDNo?=
 =?utf-8?B?SVdhMU1DSGVjMW9sSjZIa0t6NGhiMG10WFNkdHJYQWhUR05IbFgxKytUU0RY?=
 =?utf-8?B?RzFaTm5jWEJndVYxdnYrb1JvdHduTUdPSGZBcWoydHBoRnVyckViUjYrSGJP?=
 =?utf-8?B?bjZ5amJ2RTQ2K29wSk93NXQ4cW56eDJsd1NROE9ZR1NnZjVSR2VweWxkMURK?=
 =?utf-8?B?b3BqZmRVSVJCbHFaTk9UUnB6aVUxeDYyZjMrZmNpUFpraHQ0aHdZYy9IS2h6?=
 =?utf-8?B?YnBicDdEZHRveXNsOUxkSHEwZTB0dnAyS1BnRjAwME9NT0hRQUZNVjBGR1o4?=
 =?utf-8?B?UmxhcWhDQmZGRlNqVVp0akR6b0RwWEJDdVNGK090MUlSUjFWWmFnS3U2V21x?=
 =?utf-8?B?SVNCYVVZZTlERUpTMER3Ym9yM25la1dzZmVlWFVQTkFGK1V6SHhRUk9pcTBz?=
 =?utf-8?B?eDhUTUhPNWxGNjNkZERKYnlnSzVucnZiWXo0V1piU2VPQnk3YUtORHJzQmlS?=
 =?utf-8?B?ZWFUblZNRmZ2bFk4dGJaNll6emdzYkc2RU9CZEt5eUtCcCtIZjF0MUM3WXFK?=
 =?utf-8?B?bHFLcmZZcENpaHZYM2JBV1pDUFVEeUpHMFN2NGtuTXQvVnorazJ0OHVtMm1a?=
 =?utf-8?Q?TZA3w3bV6pA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEZhb2FKTStQNHppUVNvSEZpcHNwNURZNFFEZnMvbHlBbExHNjJadVNMTGJl?=
 =?utf-8?B?S0d4c09mR00ySEJWUzMrMWVOclZlNk5CQ2Zab25ZWENjRXdZQWlnSSt3cWhr?=
 =?utf-8?B?UjlObXdnNXhmUU1ld3RhaVdMUGI1N3RSL3owYkJxZHdXZjdMYXlOZmJ6RHVX?=
 =?utf-8?B?NWJTSjFIeW45aTF3RTk1SGlnb0lpVmJCMnZzWEV4eE10b1drOGxDQ2UyOFNk?=
 =?utf-8?B?ZUJiTVpSTVNJV1M4RjYyQlFNZ0dNQks4cGYwU0ZzRkJ3cjhTM1JKc3lXdWh0?=
 =?utf-8?B?dUNIbVhaRjh4emhWZWJpaVRQZWpKQjJYQ3Z2aEZyazYrR1ptaWlGYUpUeThk?=
 =?utf-8?B?WkhuamU5VStHbWtSQU8zbUNqdzdqOVB1R1pyMVorMnUrMjZhVmNlUGJTd0l0?=
 =?utf-8?B?U2xqeDlwMS9BN0VZS1FiMStoQld1dEc0TGo3YnVFTDdYakoyZmxtYkZGRmhh?=
 =?utf-8?B?SlFhQUFyV0hUSUZldG4rdDNFVmVXbUJhZ0Iyd2svS1MwNkhKMjJMYkFxUWRm?=
 =?utf-8?B?MzlnUXRWNGlPaDBybTcwVHh4UC9UcjFXdzQ4UUx6MjRBSDZPRW43WnNVRGo5?=
 =?utf-8?B?V2JNQXVWb0JEOW5kblpoMzN6bmZHOFZyRlBIWHlsN2hlalRxZnh6dmtpTzhL?=
 =?utf-8?B?Qmh3MlVJT0NmUmpFR3NiQU4yQmhncFZHMDM3QjdsTUxBbWorZXk3d3UrVUsv?=
 =?utf-8?B?c3lqSUZlQmRkb1lYSkdxNHhvbHFuWHRGcmRzTUVvZzhjR045cDN3Rkl4TDRK?=
 =?utf-8?B?WkNOUjh2Q052NnVIbTViakR3WUJnQlZtU0Vvd2M5bEdrWVZtQmR4czUvcjFk?=
 =?utf-8?B?ZkFTd283VnhWOUZSNEFyZU5vb0VMb1hmUHh2YU96Z1hjUEVlVk1CczRhRzlV?=
 =?utf-8?B?cG5lQU0vN0U4amhqWmgvcUZBZ1ZndlV2VnJYWE1lK2JLalRyamd4UXFiR1VM?=
 =?utf-8?B?bCtnL3FpUWRHNk1ldTZneDY0aGlhaG9sZkNDWXhDaGIxQW55clFybzdVWFhs?=
 =?utf-8?B?NVJmZGhvckRYMno2aFVXa1VKUXZBYUhvSXBKT3pXQ3YrNGgwdldkdVRGV1gz?=
 =?utf-8?B?TkRsdDJIY3NZZU1ibjlHU3h6ZHJwbXlPeGtjbHZWQUN5c2YrZ2JGTzdKNzFW?=
 =?utf-8?B?QXk4UDRpcWVKVndhSnhBZGptYTNVTjhmY0pxNWljaFdvcTlzd2FQK1hUeitt?=
 =?utf-8?B?a2xjZXMrVGNVeE1FZC9FWVloMW9tOFd0R1orVHJmNjJMUXk1S25ONzFzK1Zk?=
 =?utf-8?B?cDdSUVQrTzkrclhteVhHcTNJbENLMlUvQnNsNWxSMlBTNWVsRFdlbmZqTEpZ?=
 =?utf-8?B?WW0zbm1ja1hxSzcwTUFkSTViN1RrTlptK1lkKzhZNDU5YmNxSTNOdWtWYVYx?=
 =?utf-8?B?S3c3b1NycTdtREdSRnZYcVI0VnZ0NU9xUFR3WXdacjdVK1pkakJ6VEcrRzlL?=
 =?utf-8?B?UnlpbURvT0ozdUtQYzQ4czlLMDkvU2F4Uk51VXduNEVqT0tGbmR0Zi9KSFJz?=
 =?utf-8?B?Z00vWktVSjRoUHRoNHdwem5tdU90a1JEcjc1Y2R3TU9jVUkrazM2Sldxb3BG?=
 =?utf-8?B?N3dYSGQwdzZBdWVrV2FVZ1E3c1BVOTdiY2Z3cXArbG5YdkVNRlFQc1ZGZ05R?=
 =?utf-8?B?SFcvQUs0YW9PWEVKODk0Mi9jTlZRVlBoYjEzd0NxbjMwV28zWE5uTDVhb0xs?=
 =?utf-8?B?eE9xN2c5TEE0ZlE2Zzl6OVBtOXZBZEI4aVlLSCtReEVLS3Y0d0k5Q1JpNERC?=
 =?utf-8?B?SXBtbVBqNmk0L3c2M3Erb2xuNFRnSGhxOEhZZm56V0NOU2pzcXpWdmVDVzVm?=
 =?utf-8?B?ekZ3cjBOVHNjWjYveUs2VUd5QjZyVnlwbXB5eXB5a0VrdVlWME5XRWxBNy8w?=
 =?utf-8?B?a2pLekVqM2tiTFhxbTJkR2ZIaDFlQXE1THI1K2pZRW9rdVF6ME81Ri92aGhD?=
 =?utf-8?B?REdXdEZjVnJyeU1XSEFtVk4ycUY1b1VlQmVZdzFGUnlIdTltZUNIaDBmbDR5?=
 =?utf-8?B?ZDAxWXUxTUVWNEx6SkR6SnNJU3lrUUozUVV2TjB4S2FTbTQwN2t4QnJabHI5?=
 =?utf-8?B?QmZtVHBjd2k1VGpEbkFHZ1Z2QW80VHRwWTdoTlVIdEhDbWJ6YnBzbUF6dGRW?=
 =?utf-8?Q?DChfxuTJDKPRRsQwGD2oI2Tds?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01dd530c-681b-44ac-a25f-08dd8d659918
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:49:25.9519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h51x9ow0m5+QQzEpqJF1By9WrlDZ+JBtnzub/YKGBJVQosxiYu4pnsJbsjVJs+nxmC2GaKBzXN0TCltYeoUHdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706
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


On 2025/5/7 20:21, Christian König wrote:
> On 5/7/25 13:03, Sam wrote:
>> On 2025/5/7 18:03, Lazar, Lijo wrote:
>>> On 5/7/2025 11:52 AM, Zhang, GuoQing (Sam) wrote:
>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>
>>>>
>>>>   
>>>>> Please keep in mind that this is not the only scenario addressed by the
>>>>> driver - for ex: a resume sequence is executed after a device reset.
>>>>> This patch itself introduces unwanted sequences for other commonly used
>>>>> usecases. Please rework on the series without breaking existing usecases.
>>>>> Thanks,
>>>>> Lijo
>>>>   
>>>> Hi @Lazar, Lijo<mailto:Lijo.Lazar@amd.com>, Thank you for the feedback.
>>>>
>>>>   
>>>> I also think the new code should be inside a check so that new code is
>>>> executed only on resume with different VF and do not break existing
>>>> usecases. Following is the implementation of this approach I can think of.
>>>>
>>>> - introduce new field `prev_physical_node_id ` in `struct amdgpu_xgmi `.
>>>> update the fields on resume.
>>>>
>>>> - put new code inside code block `if (prev_physical_node_id  !=
>>>> physical_node_id )`
>>>>
>>>>
>>> Can this happen only with XGMI under this condition? Any other method
>>> possible like preparing a 'unique signature' and matching it to identify
>>> if it resumed on an identically configured system?
>> Yes, this hibernate-resume with different VF feature is only for devices with XGMI. Detecting XGMI node id change is the only way I can think of to identify the case. It's also a very simple way.
>>
>> @Koenig, Christian <mailto:Christian.Koenig@amd.com> Are you OK with this approach, adding a check for the new code sequence?
>
> Well you still need to avoid calling gmc_v9_0_mc_init() since that is most likely incorrect.
Yes, I will change it to

     if (amdgpu_xmgi_is_node_changed(adev))
         gmc_v9_0_vram_gtt_location(adev, &adev->gmc);

And remove the change of `refresh`.

Regards
Sam


>
> Regards,
> Christian.
>
>>> Regardless, instead of having a direct check, better to wrap it inside
>>> something like
>>>      if (amdgpu_virt_need_migration()) or something more appropriate.
>> Yes, I will do that. Thank you!
>>
>> Regards
>> Sam
>>
>>>    Thanks,
>>> Lijo
>>>
>>>> Is this approach acceptable? If not, can you suggest a better approach?
>>>> @Lazar, Lijo<mailto:Lijo.Lazar@amd.com> @Koenig, Christian
>>>> <mailto:Christian.Koenig@amd.com> Thank you!
>>>>
>>>>   
>>>> Regards
>>>>
>>>> Sam
>>>>
>>>>   
>>>> *From: *Lazar, Lijo<Lijo.Lazar@amd.com>
>>>> *Date: *Tuesday, May 6, 2025 at 19:55
>>>> *To: *Zhang, GuoQing (Sam)<GuoQing.Zhang@amd.com>, amd-
>>>> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>> *Cc: *Zhao, Victor<Victor.Zhao@amd.com>, Chang, HaiJun
>>>> <HaiJun.Chang@amd.com>, Koenig, Christian<Christian.Koenig@amd.com>,
>>>> Deucher, Alexander<Alexander.Deucher@amd.com>, Zhang, Owen(SRDC)
>>>> <Owen.Zhang2@amd.com>, Ma, Qing (Mark)<Qing.Ma@amd.com>, Jiang Liu
>>>> <gerry@linux.alibaba.com>
>>>> *Subject: *Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id
>>>> and GMC configs on resume
>>>>
>>>>
>>>>
>>>> On 5/6/2025 3:06 PM, Samuel Zhang wrote:
>>>>> For virtual machine with vGPUs in SRIOV single device mode and XGMI
>>>>> is enabled, XGMI physical node ids may change when waking up from
>>>>> hiberation with different vGPU devices. So update XGMI physical node
>>>>> ids on resume.
>>>>>
>>>> Please keep in mind that this is not the only scenario addressed by the
>>>> driver - for ex: a resume sequence is executed after a device reset.
>>>> This patch itself introduces unwanted sequences for other commonly used
>>>> usecases. Please rework on the series without breaking existing usecases.
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Update GPU memory controller configuration on resume if XGMI physical
>>>>> node ids are changed.
>>>>>
>>>>> Signed-off-by: Jiang Liu<gerry@linux.alibaba.com>
>>>>> Signed-off-by: Samuel Zhang<guoqing.zhang@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 +--
>>>>>     drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  4 ++++
>>>>>     3 files changed, 29 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/
>>>> drm/amd/amdgpu/amdgpu_device.c
>>>>> index d477a901af84..e795af5067e5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -5040,6 +5040,27 @@ int amdgpu_device_suspend(struct drm_device
>>>> *dev, bool notify_clients)
>>>>>           return 0;
>>>>>     }
>>>>>    +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
>>>>> +{
>>>>> +     int r;
>>>>> +     unsigned int prev_physical_node_id;
>>>>> +
>>>>> +     /* Get xgmi info again for sriov to detect device changes */
>>>>> +     if (amdgpu_sriov_vf(adev) &&
>>>>> +         !(adev->flags & AMD_IS_APU) &&
>>>>> +         adev->gmc.xgmi.supported &&
>>>>> +         !adev->gmc.xgmi.connected_to_cpu) {
>>>>> +             prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
>>>>> +             r = adev->gfxhub.funcs->get_xgmi_info(adev);
>>>>> +             if (r)
>>>>> +                     return r;
>>>>> +
>>>>> +             dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
>>>>> +                     prev_physical_node_id, adev-
>>>>> gmc.xgmi.physical_node_id);
>>>>> +     }
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>>     /**
>>>>>      * amdgpu_device_resume - initiate device resume
>>>>>      *
>>>>> @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *dev,
>>>> bool notify_clients)
>>>>>                   r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>                   if (r)
>>>>>                           return r;
>>>>> +             r = amdgpu_device_update_xgmi_info(adev);
>>>>> +             if (r)
>>>>> +                     return r;
>>>>>           }
>>>>>             if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/
>>>> drm/amd/amdgpu/amdgpu_gmc.c
>>>>> index d1fa5e8e3937..a2abddf3c110 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>> @@ -1298,8 +1298,7 @@ int amdgpu_gmc_get_nps_memranges(struct
>>>> amdgpu_device *adev,
>>>>>           if (!mem_ranges || !exp_ranges)
>>>>>                   return -EINVAL;
>>>>>    -     refresh = (adev->init_lvl->level !=
>>>> AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
>>>>> -               (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
>>>>> +     refresh = true;
>>>>>           ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
>>>>>                                               &range_cnt, refresh);
>>>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/
>>>> amd/amdgpu/gmc_v9_0.c
>>>>> index 59385da80185..1eb451a3743b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>> @@ -2533,6 +2533,10 @@ static int gmc_v9_0_resume(struct
>>>> amdgpu_ip_block *ip_block)
>>>>>           struct amdgpu_device *adev = ip_block->adev;
>>>>>           int r;
>>>>>    +     r = gmc_v9_0_mc_init(adev);
>>>>> +     if (r)
>>>>> +             return r;
>>>>> +
>>>>>           /* If a reset is done for NPS mode switch, read the memory range
>>>>>            * information again.
>>>>>            */
