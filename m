Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546DEC3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 14:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD97210E064;
	Mon, 22 Jul 2024 14:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DW+7kpeH";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BEDB10E064
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 14:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KT5Yj9DLu4GrKGunS/XV29RGlWwPbP9lbZ3iVHWDBXU+49qOLqJQ74vAg2JiqcThmzcSHGAFmymLSxmYx+3UiWs8gJipZaT5y68tMYKhD1+TAGn2zESaiOUVWpR2WbL4Kxg5+kvTjFZ8p2ycRnArpBpxo7stXwJzWuim2ID1SzBu4aRsGAu/ZlK5SH/og62urtzibyEQSD6XgjGdh4sJjIexMXZRQZWL79SXRjsOK3Z1c4AprC0QAob+0Bp3kj1y7QLHshmNW+wvXSwW1Dql8m8LVqq9zVjocADtn4GRQnbXL5I0tvTiaDGdSMbBVrgCLhsEquopBmh+VpFznLlgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DeLHqB9VfVDHbFXwhQ6cqILqauK6mn3rYnso1R8eO4=;
 b=pzoFFK6kcYx1aaaBMeTd7YCFOzBCPbRseQEWG1fvwjnbpiCXzEeVtDFbmksMnRa4ydiMDA1CTAh1zrmpoAMykMiRG7Ak7RUn4w8vptHQdqYZPtblWBB7GiMZXyS8kEqVVlSVduaoHmaGcqFehXKWzGA8ruDneEGRcu6ciqm/0QnMYmfHuWa79yfHXYYEyJUx3M7jCW213dSMbyH+CLIHxeqNXX1g+4RwutG746PbyaaBKIP0GweA0hrxta6IM4CsXnx8QdJ7XD0f/4dwjCNDD315OWVLwcLOw39ycwhh0JBeyIBCQdbCKL2ytjztR0DbeVxg3gQ7//X0QDE0OHA01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DeLHqB9VfVDHbFXwhQ6cqILqauK6mn3rYnso1R8eO4=;
 b=DW+7kpeHavRDFyxPy6Zo3iEhTNRrVV9+FZKuhQZTsE3NzXvgnnaAu8f61FDS+WW2FfYLxxfhwPDyWRLtV/Si4gkcgADJ4hZGikDOmhfJBV4wr+AI6zlhUgb8LOmUEXd/ExB4lwXxuPzLzV8k5IJFxMtc63IVlX8HU1AFun4uR9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Mon, 22 Jul
 2024 14:41:10 +0000
Received: from MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::71a6:a9da:c464:fa2e]) by MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::71a6:a9da:c464:fa2e%5]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 14:41:10 +0000
Message-ID: <1e27e22a-7eb3-40eb-956e-d4b63c81389c@amd.com>
Date: Mon, 22 Jul 2024 08:41:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add kdoc entry for 'bs_coeffs_updated'
 in dpp401_dscl_program_isharp
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tom Chung <chiahsuan.chung@amd.com>,
 Roman Li <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240722131514.4003098-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240722131514.4003098-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:408:f8::9) To MW6PR12MB8733.namprd12.prod.outlook.com
 (2603:10b6:303:24c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8733:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b43e8e-c1df-40ee-29f5-08dcaa5c5402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UU1CQm5NbWYrMng4ZmlGOTc4RDFzdzhrMk9Fcm41K2publZ2bi9LTEN2V3dz?=
 =?utf-8?B?VVZBbzIzdUlrdGZoQTdHeGY0WHdiVTJ2ZXI3dy9DREJPQ2pldk9uUTZ2Z0dv?=
 =?utf-8?B?N2c5RFNnbHhPM1NOSCtoZXA1UjZ2ZmRpOHlrYnZIcVF4RG5jTW5YcXB0MXZl?=
 =?utf-8?B?VjhDY0MvUnpVUEZNNmNqMWdXUGtNb005STNIRjNGeGxEOFoybzNtbHVMVTJH?=
 =?utf-8?B?ZCs5T1F4bWdYTitYemE1OTYyZ2t2WDJMS21ZQTAvMU5nbStxdlZnTWszb2sy?=
 =?utf-8?B?ajNCckJJRlQ2Q0VPTWFQaVgxY3J0c2FSbVBjTUtKNmFSQmpVRkx1TWo3a25T?=
 =?utf-8?B?VnBVUTRib2ZGTW80a293eGVza3RURTdvTCtqbEM4WUFjQ1ltK3F4K3Urblhw?=
 =?utf-8?B?UDBTcHo2K1JnZG5OeXY1amRFUlpzU0ZSMnRvOTg1ZnN6ZEhZR2VPSThORU5y?=
 =?utf-8?B?Y0JvK2xlWERudmxpOVRjYkJIdHRlakZmVkw2OWF4SkVPdXBDZ2tjdjJZdGZn?=
 =?utf-8?B?RXlBSlZhRkNYWmxJV3VYNE95ZS9iSitubUFac1ZwdGVRN2VSKzlPQm9yTWpD?=
 =?utf-8?B?ZEVZbDJFSzY3RVFVUXova1ZzUzVXWEh3d3lLdG5uL1RlRERnNU9sek83RDAr?=
 =?utf-8?B?L041NHJFaUh6NGdXZlh1RExpQkRHRHBZMzAxUWg1ck9SUzRqMmFpdHArWWJC?=
 =?utf-8?B?OUFZYW5vQjhDQkgvNEN3MVBNZnlXNHpVSG5WMUVGNHk1cE1DT2pLYWJJRHRD?=
 =?utf-8?B?QWVqMFdhQmh2WWJEQjBtMXhCaGJOSzg4VklqdEQ5OGVkOEtYNStwbTFSRGZZ?=
 =?utf-8?B?ZGNyaEt0blhBNERtQy9CaGVmRWRYVzYvc3RaVFVlOWhPeWY4WVBVMksyZXFF?=
 =?utf-8?B?MDFUaHRwNm82WDVKOW05WTRoRUdSM0daaElQbld3NHhReER4NU4zcm1abTd1?=
 =?utf-8?B?czdXam44c01ubzFadzNTbWJiNDlrVGU0TFFHRmpxTDVlc29ZYmRnVTVIaDJ1?=
 =?utf-8?B?WjJIQkZSdGFBTXk2RVlHWEhNUzQzblVVdmpkemtaTnY2S1habFJHOVArd2l2?=
 =?utf-8?B?NlVqZzZ2UlE5d2dsWFZ5NW85T2Y5R0s3eHRkUVNJYmVtUnJOeGVKZWRlUGRn?=
 =?utf-8?B?ZmV5NzhBQ0RkNlF0K08zcVd5SUlYRUt6MUpjY1BsRVdObVAyaS9xOUlsV1Nw?=
 =?utf-8?B?V2JURklqbUQvZzhoVGdFZG8wMFNGYlpHQnFlM0R4NTZpaS82ekd6ZkdaOFNJ?=
 =?utf-8?B?U3lSM3VaOGtXSlV1VllxM3ZvQmRuckxoWHJQWnUwY1IySXBwem1ZL21PeWtO?=
 =?utf-8?B?dHQ4RjUydnNqNG9BTjF5Q1l3NllrMnBsQTdYNGR0NW5sdHQ2dFlmM1dXeVo4?=
 =?utf-8?B?Z2VmRE1ZK3ZRM0xPYjFBdkQ2ZWFHV1ZESURNR2FSZWlFdUpERTlySTJ3elJ4?=
 =?utf-8?B?Q0lJSG9BYUh0alpwYWlLR2hRWXNzMnhONlBvK09yQzRYVWh3WlhsblFNa3k0?=
 =?utf-8?B?c2RmZTc3TjhIRnhndWdFRVdldEZTaG55RmpUeGZsMGxmTExneTBGREVIMEo1?=
 =?utf-8?B?OUtLVEh2TjB2YUtlQmVibXU3bi9aMXdveUpnSXZqbFlIbjZKQ3Mzcm5hK3FU?=
 =?utf-8?B?L1ViaWNlOE9BUFdHZkpLRyttNk5KRWoxaU1mTVRaUmRxVGp1aytzeDdSSVZR?=
 =?utf-8?B?SjRHcnFNaHRoemxEOS82cXhpTGdTTUMxMkI2YmJ3MEoySVdqU2NHRmo3OUZR?=
 =?utf-8?B?THV4c1NVbGxERDNQVm13bnYxTGtUMTJDc0VTaFdXRloyVjNCZWRNVlNkdXhR?=
 =?utf-8?B?dUh2Ny9qeUUvVFZibllidz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8733.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1krdXVDTEZJWURKalNBTGFoMVA0QzVkVlhweVRHNm5YQ1NaSHJNUzNlTlpR?=
 =?utf-8?B?TWV2a2hTVXk2ajhNWndvcVp2STZPeXF1RTBKVVcxc2ZuYXhHMzA5Qm0zWnBV?=
 =?utf-8?B?dU1jRkdlV2JyV2RzMVo5V0lpN284dXVJdnhXMXlJcDBvUjBWWEhiSjJpdHZx?=
 =?utf-8?B?Wi9odDZEbGl2TXdBd0tJTE92Uzh5L2x2SkVwTWpKM1ZGQUpJbDhpUjBRaFhD?=
 =?utf-8?B?Vjd2NHhRNXZkY0VDVGc2SUhlempVRXdITEFOSFI4TzNZT1RZME9lVGtQMmdQ?=
 =?utf-8?B?MTNYdHllQWZKY3BWSjMza0N6LzQ3S3hpaFJzOW83UDJQWm5xbG1QQXQ4OUFO?=
 =?utf-8?B?SUdYODI0aU13VEw1NDBpa2V5WmZiYzl1TjFmUE1scDNPYnVQRXMwNkFoZjhN?=
 =?utf-8?B?ZFNPc3pBZ1p1MnNjbUM1YlJCRjZoMVpaZmZCeFJrSjNSbk02SG5DUDFoMmUx?=
 =?utf-8?B?Lzc1Mldpd2ptNVIyTTdlZGt1V053NnN2bytSelZ2Zk5ILzJWQVpMVzVjb3ps?=
 =?utf-8?B?aDBDZ1BWUnBsbU0wMEI2UDZVaFBSOGJLWkxqUHNUNHBMNmFNQzhsdGRvellP?=
 =?utf-8?B?bHZrcUYzblFLTnlWaXRQZjVqb3RFVktFYnhyRFlxSEk5NXBZUjVTaExodFh3?=
 =?utf-8?B?VTBwNk9BNEpxQU1YS1JPVllNVWVmeVNZRDZ3Zm9hdVJIZTJGb21XOExOSWp4?=
 =?utf-8?B?M1lMaGEybS9KMmpQZTBDUm1PSE0yNGZFRVQyODFzczNPTWNkSEpTMHpHcUNC?=
 =?utf-8?B?WFNEY0wxb0VRVXVzVE83NW52aTY1RDBUOENJZi8zNWtHWlhRenBhbzNGRk9m?=
 =?utf-8?B?bVNzM2wveEQ5akh3T3JuSnlUcFV6RDFDVjBZUkxaQ0k2bUVmTUF2R3Jic3BY?=
 =?utf-8?B?MUNSNkx4VUtUdUkwRHJZM3NFZnpjMWxCcFNwbWlTTHFaQ2gvaTBqQTZORnNy?=
 =?utf-8?B?aFZNc2lyblBMQzR0b2VKY0NzWHlYNkh6ODlraDRRTFliclBsai9nbExTQmFE?=
 =?utf-8?B?RnU3bUV2KzIwNTh1SEV4U1JFUUhIWTVlMko3ZUNPTURvdUlsTUNlcERVS3VC?=
 =?utf-8?B?TC9JMW9OTlBpdTJtT2t5a0k1cW5NZFo3Y2paR2pveTJTUWpBM3UwTFFDbnla?=
 =?utf-8?B?dUltU3BnaW81bFIvRXFuRndJdll4ZGFjeEtGc29ZTy81aXk4ZnRaWnNvNG1M?=
 =?utf-8?B?YUU1LzNyUEtsVHJHMmYzR25vcXU5aDdMcFZlV2xpaUVBNmo4QUtuQXE1QjNH?=
 =?utf-8?B?ZG5uMEdQME9ETVhHUzUxNW1QcWRMdEo1c0dvVko4VVBSN1lmR1Q2MkFhdlR4?=
 =?utf-8?B?aUx5UUswaUMwcExXMGxDeWwxem9nbi9pdWRuY3BEa0JmTkxoeU1sWElmcHE4?=
 =?utf-8?B?b1ExaDVSLzN0OW9hWXVmYm91S2VqaEI3NG5TOHM4NHhNSXNTbzUraEx6WDJM?=
 =?utf-8?B?aTZiQVg4dVpKRU5zRDlpdlJxTUhWNnhKUG55ZzJOdmNaSmJXTDZWelBhWTRx?=
 =?utf-8?B?c3FUN29sMTAyM1I2Smd2SDdzSmxrV2dEbWFzYVlWbktXS0pQZit2ZFptbDcr?=
 =?utf-8?B?aWdlQld0L09oWC9ySGpWYnZDcjRWeXp5ajc5QmtpNUcxdk1FSlhPZ3JyZENI?=
 =?utf-8?B?Q3pKYnN5TkxnMDlOQWRvZU5ZeWJuTDlDUk9Ca1liZTdMeGtsUVV1SXNlZnJH?=
 =?utf-8?B?bzFlVFp4eUd1U2xoWkdFaXNHUHRqSFhMbU92aW1GMDVnczZDdkJEdjYxZFBY?=
 =?utf-8?B?SkdNQ0V3cHcvWDQ4N0szdnhHVzh5dVJUaml4OHJIZ203MVRkQ1FaSks5WVZU?=
 =?utf-8?B?b2xaaDN4d21sUEhua0Y2S2FMcUZkVnlsYmpLazVPeVFTaGw4eUpoenNJME4x?=
 =?utf-8?B?VFM3NnJBaVdPN1JmL20xaEpYaGV6c0VDNE5FS1lDZ20wVXJGeXFKTUl4MDhC?=
 =?utf-8?B?VkFtKzd5ZXozZThnclhzNDgwZkNTNWdNRmNUSS9ZczV1bWVXcFVyMjlqelBZ?=
 =?utf-8?B?bDhIdFBrN21NdHFQZUZVQ1hvMEFFZnlVT2RlQUorUWZzdWZVaUxzTUFJVSsz?=
 =?utf-8?B?NTByUXBHbWl0TU8xSUVXWUhnWTBmTmE4VVBKNUxvbklJMWhaR3QyTjVHVHBK?=
 =?utf-8?Q?AhK6dc6ZUwcFqPiOuy7DMRcRD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b43e8e-c1df-40ee-29f5-08dcaa5c5402
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 14:41:10.4786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDEHIEwtjUtWbUUXUUMszThcBziGnjfgDpxs8b6QGgfTJUqzHGqwVK8e0uXwVRgTpaGX/q8VggeRr4DSPJRd8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647
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



On 7/22/24 7:15 AM, Srinivasan Shanmugam wrote:
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dpp/dcn401/dcn401_dpp_dscl.c:961: warning: Function parameter or struct member 'bs_coeffs_updated' not described in 'dpp401_dscl_program_isharp'
> 
> Fixes: 431ae65ea4e1 ("drm/amd/display: ensure EASF and ISHARP coefficients are programmed together")
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
> index 703d7b51c6c2..3a3745597f0c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
> @@ -951,6 +951,7 @@ static void dpp401_dscl_set_isharp_filter(
>    *
>    * @dpp_base: High level DPP struct
>    * @scl_data: scalaer_data info
> + * @bs_coeffs_updated: coeffs update flag
>    *
>    * This is the primary function to program isharp
>    *

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

