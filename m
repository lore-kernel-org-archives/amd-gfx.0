Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C03CC0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 03:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4CDA10E2A1;
	Wed, 29 Jan 2025 03:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="awjXhyx+";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 844DC10E2A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 03:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJ6nBKdxRnCROOlPjspJ1zD4+xn04PkeuPLr9GabUSgbecNeEPNO1SO9l2cWOoRveGtLWRH/C/rfYev1XnA+xDpm8P8Fr00e28FQjHFBLx5c9qiux/hRAcvI4xHwB0aN1OG/OnpFPn20WfGMKjMeJVFQ4PmsV6+lufZF3v8mdcWu73KtOKu24lGnJOkXOunbgrQ6igRmA4VZv/mBOC7vBYstX8wuQd9xVi3Mkg06R5LMPJfL9K/hj1hEliGDBLR1nETybN2TKj0P1JRiKzYJX84c5epKknmRlC4jaJT7ZM4TmCadqaUa2w/DP/OcMQgjpglbQ8EKlCwtMDW2o7LzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1DxDydtlnVtcd/tpjrRj4ldSttbg+1DQeOe9Py7Fj4=;
 b=IoHpiS0LHMCTrTcZtBJx+ojo/jdot1ZZ0YCBeeDewJSbugeaufJQ9kii74WJLq34XDNuaFQRPeBriCeHfIkUJ0aMvka+9YX3xRv8Hbvm57ZFxO9gQb+oHNc/EIuvhhG+UpMloADiRVyXEI6ajztctQDjpBNvHPQB5BuHLb9lpWHbaYWY5MAuaCQbLybmMqRE68M+5gyMpjOMWkkjCPipQFi6SQJCA+eHBxfpEQYwg+3b5gfKSDTD4ROGgFP8KTKIrANhBP/h+NqeXrW94UkzY/8he2CZEfJOPxWqjJ6ETaQdOSlXJbAkJKE0VhaYVr8q143M6c6c5ecv02gm5f6/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1DxDydtlnVtcd/tpjrRj4ldSttbg+1DQeOe9Py7Fj4=;
 b=awjXhyx+vp9oSuhejo8VKpZV88ixrRSodC69QUgHubz7t/7+o+d1mKqj61E0SzEaYk61csEBA51lMWKwaW8TW2JbTxcAxWY/vnsh2QmzPv1owwlEMW5Y3h5VWaT3sa3FRG9OTxQ/hwMoQrbSgGDw/5vI+XX7jkk70RXx5Z+5z4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by PH7PR12MB7185.namprd12.prod.outlook.com (2603:10b6:510:201::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 03:53:13 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%4]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 03:53:13 +0000
Message-ID: <70be699c-d61f-4022-8317-58cb15424b49@amd.com>
Date: Wed, 29 Jan 2025 09:23:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Use version to figure out harvest info
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Le.Ma@amd.com
References: <20250128063115.1690375-1-lijo.lazar@amd.com>
 <20250128063115.1690375-2-lijo.lazar@amd.com>
 <CADnq5_OCDkEx2tum+=eXZ2wUaYHSdDc_iePZzhr3Zj96y7gb0Q@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_OCDkEx2tum+=eXZ2wUaYHSdDc_iePZzhr3Zj96y7gb0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0221.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::17) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|PH7PR12MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4c6974-1b11-4a3c-2b4d-08dd4018743b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVNWYk1ra2czbW11MFdWWjNKZHBYVzh0RndRcDBBOXRxWVV3dXZpbGNtVlZB?=
 =?utf-8?B?bWI5SlV3Qis4S1VPc2dnN21Mcm54WEdnM1dMSUlkOTFmZnIvMlluVWwwenRZ?=
 =?utf-8?B?QmN5alJBNXJsN01NemRlOVF0RHNnbUpQMlBLNnh4OVkxUjVlSmNXck1lQ2pm?=
 =?utf-8?B?WUdlY1F2T0tjOFhKKzl1bWFGOWg0SlpnWE45K2dSc0NPRlh6aFB2T0xBT3Qv?=
 =?utf-8?B?WjY4WEI3dXdGV3BmTmVYYUhGT1dPaEk3YlY0KzFLaFdOQVJ1ZHd3YVNNT1FJ?=
 =?utf-8?B?eXE2cTZ3QlRzVGg5amtLemhuTkcrcmI4dFBjNWFMZmFEWXdxaXJyTnNVK2dG?=
 =?utf-8?B?VU85TG5vUHEzc3pSNHZZcHArMlErTFJVWmYxSk8xS1JuTWw3MnNYc1FoaWhw?=
 =?utf-8?B?dGRudlFBS0FQbmQvMjRvQ3NaaEkrY2FaSXNzejYzTGpJeHBOUWRoSUJWRGlw?=
 =?utf-8?B?NTV0cHNpU1d1aEYrYlQwSUtUQ05vUk5WSVcxM3BUdXRIdjFrWHduQXJZWE45?=
 =?utf-8?B?ZEphWStRWjFEOGVQdUVJdFM3TzdlRDlHb1gwQUZIZUxoOGVTamlvTzVGc0Ex?=
 =?utf-8?B?ZVJUbWJ2RXJka29OWFlkRWZBSmcxVk5FaENValJYVWsxWWxSOE80eTF3alVo?=
 =?utf-8?B?N0hUSTdCKzdoV3B3NkFwLzU0V21NbEJpT0NhYnZ4SWdBTDZmNngrYmJLeWtN?=
 =?utf-8?B?ckxad1VJSU9mTlBQT0d4enNVdnNuMllKOXpqZk0wdnFUY21yd0VTdk5QNjJN?=
 =?utf-8?B?V1RjMi9hNmE0bDk3S3pKUU5uREpURVVPUE1mVHduSU9UUW1lQ3k5czFXM09v?=
 =?utf-8?B?bUNsTGRERjYvaWVHSnJNZ2xCcFZwUng0dktYWTdxN1RCQjNHTXBnMVcrazBX?=
 =?utf-8?B?Z2wzQWQycFRIZjBCRXJxZTFDbjFGZjhKZWtuMnljKzNkYUdvRUV1ajdwU1ZS?=
 =?utf-8?B?THB0aENrU3pWTGNtYkx1RDdDb1dEK0Y5bTVCcXBMMjlVOXExcGprUUNvT3hK?=
 =?utf-8?B?WXZSVThHckhYOTd1bEF0cWZhYjIrZzdpZUtSajc4TWtLazZmUTZFWWNsM29W?=
 =?utf-8?B?TE5jYTVPZjhpVDV6UmwzNTdTY3V5d2J4OUdoN250SUZxRUZTTVRSZzRvVnZx?=
 =?utf-8?B?ZmtxajRQVnJ5cHFJZTNtcUIrbjJWN0JPVmF3UEZkbjh6MEtvWFlQcy9UcWt6?=
 =?utf-8?B?M2N2UHdpZGJsdjdoOVUxQ3ZUV3FlT3U4TjBUQXBZbW1pTFpHUTdQUjhWY0Ey?=
 =?utf-8?B?Y1dySjNOTGlpMGNlMFRCS1dSdnRrTWxOaVhvbnNqMHZpR0Y1cnF2UWtGM3gy?=
 =?utf-8?B?U0Q5cW92WWk5aUlHdkwzLzhaTVk2U3p3bXBqTWJNcnZJUU1uVDFZbmlWVkpC?=
 =?utf-8?B?aWZSeGNocVkvZFlmMmJKcjc5bjhZc3B4cFE1VFRlRlRsUHE2c3NtejFnZVhE?=
 =?utf-8?B?aW9lMVFsUWoyMHlIUGtuZkR6ZWtRNHp0NUxlVS9RcGV6Wld3OGJmTjh4U2NK?=
 =?utf-8?B?bm4wU1AvODNsK3k3MkNGU0hicFBFQU4wVU45ZHRXY0pGV042cHR6YjF0cG5r?=
 =?utf-8?B?RzVHRUpyQ05DblhZbWNQNUp0YTAzVkZNY1N0c2R4YkpuVlNHK3A2dEhKd2ts?=
 =?utf-8?B?cFp2UTQzMHczTlVZdEdGZU1WdUFrbDlrUyttem9xRysxSkpRNFpGWXVlLys0?=
 =?utf-8?B?VXIrYVV4NHl5VlJJd1FWY0N3cjZoM05heEt1NHpJQlg2dmJkWEp4WEcvakM5?=
 =?utf-8?B?M0ovaTlac0xZcUlDeExuaTlNTFdtdjQ2YTQrUVZmVUViTFNUOWRkcXZFMk0v?=
 =?utf-8?B?OGhmM1JqYXczN3JaV0xCTU1abjFtSFhuVkhXM0dwSTRhTkNDNUp3SmFGTktw?=
 =?utf-8?Q?b8TxGrBdQStX2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmUyZjRXeHlkeDU2cFM4NUVFdVhaaWtmRDdmTlBXcHRmZkVjbFY5SjJoSjlz?=
 =?utf-8?B?L1VLL1Y0K2xzRWZzTGhoRmRkRFcwRkxGUTVhblA4cXR2eVlWYmRMUFROazdT?=
 =?utf-8?B?MEFTYXA1MkN0RW1Kd2ViWGVhejc0bEs2cDJLSTBRZ3NwUEJxQTRvMlgyY3FD?=
 =?utf-8?B?ejRXYVlRYTlnNXBjbWtBWDBCak9HSXlvTDljZi9SRy8yMkZBMHlwSFBaV2RE?=
 =?utf-8?B?QkZodkJ5WlVjL0RlT0I4SFE4Tm45TFhvRXFsSkVtMDU2TXRmMEZXOE1jVzdU?=
 =?utf-8?B?azZjdUI5c2xydUdYcjVHR3FSa3hoVzZNd2NoZ2ZOZkI0d3ovRjVQMzhMK04v?=
 =?utf-8?B?UlM2allrMkNicFcyYmFCRU9lRW5UN0YwRTJyeEI5am9sZ2ZNeW82ZnowenU3?=
 =?utf-8?B?V2xvNFdUUlVOUGt0MjRUeDNZWkdQb2poeGRPeDBvUWpPZzVCRUU0QzhhcGF6?=
 =?utf-8?B?cjFqSktBcm9SazJJbk9SZUlrcmlzWlk3ZlpvTWN5SEZVNVhSeFR1SmN2bTJD?=
 =?utf-8?B?UzBKMjl1Ym1KUDhmZ2dSa3pnVm1GdTd4czgzR09YNG52K1piWEhnY3lWZytQ?=
 =?utf-8?B?ZDVXQStYVkdoSXlJWm5yVFE2ZlN2YXhWSUNQR1NrVURFQjdBRTRRbzhzNDBq?=
 =?utf-8?B?S01oWmVJSG9UeVlia3RZS0RrbW56RlpNbXE1ZTRKUTJHM0k5QWI3Skd6Vmhw?=
 =?utf-8?B?WnBLbGhiVVNWY1JCY1dMcFlqdHk2ZDJrVm5McjM4bExaWjVWS2c4TjJBZTdR?=
 =?utf-8?B?cW13RGY0R0V2alhpNFJHNTJzTGRrc2JBSEVKT0g4KzhEZ3FRMmNWYStqc3VS?=
 =?utf-8?B?WFowOVc4RWplOURPUGpFYzVzYTBpclFFYnpoYWNwcmR2cmZsSG1tVGl2bFhV?=
 =?utf-8?B?bm9lT2dDaXd4OFFIU3c0czNEaTdkNklkaGpjU3NsMHloeDhMUUtWMnNjQ2lh?=
 =?utf-8?B?bkRsb1FLcDBDeVpXSWpCOXpuS1dXZE5jNUVRMzYxVHlYeVpqNjdVSWxLM0tm?=
 =?utf-8?B?K0RlUE1CQ05yWkdhMzZZV1o1Nlg1aUxKZWJYeS9sTHR5bVM5M1NOdXp5ZVZS?=
 =?utf-8?B?ZEM2a2pNeGlleHFEaWoyeHUzYmVWT1o5ekJyZWIxcThBYTJxdzhrWTU1dlJn?=
 =?utf-8?B?UGNlT2JkK1FQWk5UL3NSVVk5ejZNQTVkUXpwc3RIVG1GWjR4eStmWkZoZ2lh?=
 =?utf-8?B?bGVWNTAva0JmM2pOdUR2N3FTUVpFYUkvRVhkdUx3dVF1Q1NMYjZJamw0UkFv?=
 =?utf-8?B?K1plOTNNSFU1dThIRkxNSUFEZmYvKzlKYU0zc3RXOTdwbSthZFp5MDZUdVhn?=
 =?utf-8?B?QjNaeUVqWnJBRWhXRHJoNGdENmcyRTNsTm9zbmVQVElqYmJGWVdXS2M3THJa?=
 =?utf-8?B?QmxGVFpLd05FWUZWditndENPK0FOeEJ4bU1rVk9CcVhFdkZWNXIxRlpoanJI?=
 =?utf-8?B?dlJyalZ5VVd3L21OSldYelJSMHJ3RlcxYVZvQlR3UEtqNi9VZUtwaVZXaTJ3?=
 =?utf-8?B?OFY2T3dOZ1dEeDN6YlJ6TXlzWFd4R3BYZFBJbjNrNndHVTZBQi9QSE5yenI4?=
 =?utf-8?B?OEFQUG1KZEtjZWJEcncrK2hydlUrS25KQ2F6bWRSbytxUFR3eGF5RmZTLzV1?=
 =?utf-8?B?b3ZISkdMM0hJWGNRRWZORk00RWdIcytoTVRJdmpMUmlWZnhqeTgwcURrTDlL?=
 =?utf-8?B?TTdJM1c5RnBPNVVCYzVTUkgwdXRrTCtmNXFrOWgzSmlhS0pXOGxaOHhkYXZm?=
 =?utf-8?B?ZVN1UG1aS2htbk5wdERVYk0vUmE4aEM0YzBTMTVnZXJ1UEkxRlhuRnBScjMw?=
 =?utf-8?B?OTJTTTg2RHJFMFlXdldkbXZzU0hLcGlLbWdwVHZ3cjNHa1laWktUMTVXMG9v?=
 =?utf-8?B?eUFpQUJscDdCN0NlYkJHcWJNMSttZHpKNDZLSStsbXhxM0JpaHRZeElNbTVv?=
 =?utf-8?B?WTVsZFJ4dGp1Z1o0Q3cwVmM0cE42SXV2VmREaVBibnIycnJiTzZUU0NCeHp1?=
 =?utf-8?B?T0pIOXhVSjVkejZOdnZBbjFmUlBvanBWQmdldXJ4NEFnRnU0N0Q3WUVreVU5?=
 =?utf-8?B?SFIrVTRrV3p4RWgva2VybFExdFFhMnI2WGJRVmdubFRUU3QyQU9EbjZ1NFZt?=
 =?utf-8?Q?6HE8M5btawrx2Vkq6tHGEAn+t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4c6974-1b11-4a3c-2b4d-08dd4018743b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 03:53:13.4367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkyPfjBBrGTcr6komXyp8iDQU3PNvZrBT/PqYvqpxcoMLSoot/gmMMFtpAfz74Mq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7185
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



On 1/28/2025 9:01 PM, Alex Deucher wrote:
> On Tue, Jan 28, 2025 at 1:42 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>
>> IP tables with version <=2 may use harvest bit. For version 3 and above,
>> harvest bit is not applicable, instead uses harvest table. Fix the
>> logic accordingly.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 27 +++++++++++--------
>>  1 file changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index d34b97a081d8..e3afdf933dc8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -612,7 +612,7 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
>>         struct binary_header *bhdr;
>>         struct ip_discovery_header *ihdr;
>>         struct die_header *dhdr;
>> -       struct ip_v4 *ip;
>> +       struct ip *ip;
>>         uint16_t die_offset, ip_offset, num_dies, num_ips;
>>         uint16_t hw_id;
>>         uint8_t inst;
>> @@ -631,13 +631,14 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
>>                 ip_offset = die_offset + sizeof(*dhdr);
>>
>>                 for (j = 0; j < num_ips; j++) {
>> -                       ip = (struct ip_v4 *)(adev->mman.discovery_bin + ip_offset);
>> -                       inst = ip->instance_number;
>> +                       ip = (struct ip *)(adev->mman.discovery_bin +
>> +                                          ip_offset);
>> +                       inst = ip->number_instance;
>>                         hw_id = le16_to_cpu(ip->hw_id);
>>                         if (amdgpu_discovery_validate_ip(adev, inst, hw_id))
>>                                 goto next_ip;
>>
>> -                       if (le16_to_cpu(ip->variant) == 1) {
>> +                       if (le16_to_cpu(ip->harvest) == 1) {
> 
> ip->harvest is a uint8_t so it doesn't need byte swapping.  Other than
> that, the series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Thanks for the catch. Will make this change before commit.

Thanks,
Lijo

> 
> 
>>                                 switch (hw_id) {
>>                                 case VCN_HWID:
>>                                         (*vcn_harvest_count)++;
>> @@ -663,10 +664,8 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
>>                                 }
>>                         }
>>  next_ip:
>> -                       if (ihdr->base_addr_64_bit)
>> -                               ip_offset += struct_size(ip, base_address_64, ip->num_base_address);
>> -                       else
>> -                               ip_offset += struct_size(ip, base_address, ip->num_base_address);
>> +                       ip_offset += struct_size(ip, base_address,
>> +                                                ip->num_base_address);
>>                 }
>>         }
>>  }
>> @@ -1474,18 +1473,24 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>>
>>  static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>>  {
>> +       struct ip_discovery_header *ihdr;
>> +       struct binary_header *bhdr;
>>         int vcn_harvest_count = 0;
>>         int umc_harvest_count = 0;
>> +       uint16_t offset, ihdr_ver;
>>
>> +       bhdr = (struct binary_header *)adev->mman.discovery_bin;
>> +       offset = le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset);
>> +       ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
>> +                                             offset);
>> +       ihdr_ver = le16_to_cpu(ihdr->version);
>>         /*
>>          * Harvest table does not fit Navi1x and legacy GPUs,
>>          * so read harvest bit per IP data structure to set
>>          * harvest configuration.
>>          */
>>         if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 2, 0) &&
>> -           amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 3) &&
>> -           amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4) &&
>> -           amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 5, 0)) {
>> +           ihdr_ver <= 2) {
>>                 if ((adev->pdev->device == 0x731E &&
>>                         (adev->pdev->revision == 0xC6 ||
>>                          adev->pdev->revision == 0xC7)) ||
>> --
>> 2.25.1
>>

