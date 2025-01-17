Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A246C02188
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 08:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D63010E2EB;
	Fri, 17 Jan 2025 08:57:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MdCAGC8N";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6050F10E2EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 08:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjjdEMZ8nifBzazxTlKii3bGXhlP82QN4Mbl/RoNFMorLEzIlfTXpQQtOdvsTbxo0oBk+mdijgZyt1WjwMTYP9rKQtGvUBBDilORSUVhGGlQ0t0gap02XnKCG7M6WQOXa8Xssnn58vdvRrCPe4UuQYAleRemwN4533v3mxA9c6ojWjzDQmOwIUvOsAHOS+Y+ND3V0UB5F0N7OUkA7orihEQ7McYnG+Z2ef1kpgyzJ33CSVpsUZC3CvnJi1jv+w3iS7qODq4pII4jUBP9E9e4nbNOflpNp5MHQxcyzDww5vGBgGhv/8EJOsqen128fpR+DJra3WjxBQAxOohz/cBowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx0opcYKCwbqxZVS58M5hO0GDuu9iHgQh6JyGCNiJsY=;
 b=HEyHrSTLOPx+SWyMlgaO+989E1TRvB4EROGJqtWTPSGjfGitzR3TaU2/oeT56cQVIwk/FtOUT5EIL9MmaIaf0QGXhqEFM1n2fCyGXmUvuBBBvqsN8aC9urRj8nugJSXtu3NIC9Al0Soo68BqkmW5kzouWmWSyDUMfbKIKe/aYMKQiY5ehS7KtM5RrIsuWCUkJlx7Kopyado441JEHdKrW00+EOFmJiuSB/ExV7sGVritnvRiaPntn72XzngoTJpjMw08WbYODsCx00pFmP5Z7bNL5Pyjb8b6l+Ndp6k736vDz/BGEPwa2iQU/NVeNtpPWAIW0E0ORsI62ZzhheY8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx0opcYKCwbqxZVS58M5hO0GDuu9iHgQh6JyGCNiJsY=;
 b=MdCAGC8NF4BFvWZaPrlBjPePQi8OhpriCB0mrISc6Graaq+QLephynn28gPPcNFuUNw6PdHvRkmnOwulYWN9+dcDuPgiwPPoEE7s03gQylEMDLEflMnNFIyLUcKoY+1/oXsm7I0XCofXkok7APJXd1CGWj69LILMTs37L7huq4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Fri, 17 Jan 2025 08:57:26 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 08:57:26 +0000
Message-ID: <669c0a60-bba8-4af6-919e-1bc3113bde1e@amd.com>
Date: Fri, 17 Jan 2025 14:27:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 11/15] drm/amdgpu: convert ip block bool flags into an
 enum
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <17736b6c6c4cd8ca3f87800c469ff4a95429d5b7.1736732062.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <17736b6c6c4cd8ca3f87800c469ff4a95429d5b7.1736732062.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 440395fc-a8e4-4569-8210-08dd36d4f6b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUhwKytyTllkQWxsMFpjTll2UDE4aWpoNjh5ZGZnSUROZlA4MC9hZVFRU0c0?=
 =?utf-8?B?M1Y3MWZhVGJPWEpwOWRXK2VQNFBPSzdzZ3FYeWk4Zmw4VmErS0ZRd2FRMWNR?=
 =?utf-8?B?bXFkMmFxcjNWUFFKcGpYcXNoaDNwdWswaHNWQkZwYUZZMGQycEc3dWttbGdL?=
 =?utf-8?B?SFJ1TXZpeWNpTUl0czZqL0pWOG9tYU1LL3ZWczE1cEptUDNZWXJnVzhWbEph?=
 =?utf-8?B?TUJqVitjYklqRmYvV21hbFVscjZyNXkzTkprYkY3TWpCSXNuMWpqWWJMSTc3?=
 =?utf-8?B?WFQ4SjN2Y3gzeG1idXdqSXNBL1lUN1JuVWxUV2VYNlZQdWFVUGRhVkR4ZzVs?=
 =?utf-8?B?eXhkVzduZ0QzdW8wdTg0KzVTZ0ZmN1JPRHpyWXk5SXcwR1kyZmdCMjljV3Nw?=
 =?utf-8?B?UXZJeTRMb1UvendqSVRNbkc3cituUG16RXVCclVyMGVWNTVTWE5lUVNtQWNh?=
 =?utf-8?B?UU5jbWpJZlYrWU1IcUdPYlFxazRodEtlbHE2UnBCWWs0cC8rS2ZPbnhwb2hK?=
 =?utf-8?B?cEF2YzVoMW5jNUFKRDJsUU1EVlR6djM4TW9zUWpma0QrMmZmQzVOTndnSzRr?=
 =?utf-8?B?ZTltZVViTVlSWXE1Vmw1OWpNaXcvREl5ZW9nU0YzcUliSnpiei9jQW5mcEFG?=
 =?utf-8?B?bmcraExMTDVSYWp0elg5QjF6bDVmRjYraXpVOHI4RWdEb2tYVWZmUjYrSXBr?=
 =?utf-8?B?dnlTb0lIdWExdVJwL0piaWRYWTRMVHBDeWlqYmpSK3JRSjVEV0FRUDlFQUZ2?=
 =?utf-8?B?NldlVXc1NW4xR1hVWldNU3gxR3hjVGRSanZNT3NMV1BEdVRtTGlObFZKb05T?=
 =?utf-8?B?ZG9KUGtGTm1oNi9EaTRGSzdOS3M1NHJsOVF5a2F3OTNGQUZFcGNZN1FCaHZ3?=
 =?utf-8?B?alhXSmZQUTAzK05BQTJtR3lxK29TNDFmK0tLM2ZUN3JhQlppSkxIS0tBcXRy?=
 =?utf-8?B?RzJadElLU0grVTU1ME5DU3RBMVNhcldaZTNKbmtWTitrNk9iVEdKalNUOVY5?=
 =?utf-8?B?ZW5CVGxlVE9TVytLZWpZNWVRZ293aU9GeHNCS0tzVTNTM0dCVEdHcERXa1Uw?=
 =?utf-8?B?NmZlZE5nMGxUUFVybEV1NTVhRytXN3NxTXh5SjN4R2JQdkFZejc2ZDFxYkQv?=
 =?utf-8?B?emJ2QmoxR0J2alVkdHRmWXZmNlZYVDJvdStsb3ZkTEZoZWNDc2NsSVlHS3ly?=
 =?utf-8?B?UXZ3TXZ4RHJEb0NnN2xPWVN3SWJqMjJIUko3eFRiV2pvak5aTStIczdIMTFa?=
 =?utf-8?B?aTBRbFgxNjY4cXREV0p2OThZejdtb0gxTWc5d1dCVXVOMlpkb3dWQnVEMHhj?=
 =?utf-8?B?eEJZekh2Njl6WG0wT2VmQm5IWTc4dEJMR2toYXkyby9VakdNZnVubFYveHVX?=
 =?utf-8?B?WjV1LzI5ekVnK3ovUWZSNnpuY21qbVB5aUFCaDNCcnR4aW53d0RWUlFsTFp2?=
 =?utf-8?B?QnFUNXhHTG1hekZSYVpiQ3dPMHRtSmRwRjVjUUZTVDRFdk9DM043UUtmVzV0?=
 =?utf-8?B?SHJwa2EyQ0FRU0Rkd1IxV3JOdVlQNTM3YkRWQVhPZVdhc2NmREJlaDF5L0F5?=
 =?utf-8?B?TGlXUWc5WUliMVd1bVNDOEFTOUIydXNXMkMyWHFtang5Wm5XcUUwQWNybExH?=
 =?utf-8?B?M2xKRjNjQ1J5ZlVwcXNIS1dsVmpLZWVFa05pd1V6QU1JdXJLV0xrZGtqNGhr?=
 =?utf-8?B?MHl1eWxXZEI0YXJTdk1pb3BCa0E1aFlGb1BpK2dITmgwMUJsMmtKZ2w4THBx?=
 =?utf-8?B?aSt1R2dqbEp3YmJCWk1hcldrdjZZdG11Z3pZVllGTlRJV2lBSGFNTVgzQkQr?=
 =?utf-8?B?RlZrNTJzM1hlb1FiYjVJa0x6K3AxWmV4MzNPZ3d4aUFZaWl1aitiRUc3TlF1?=
 =?utf-8?B?TzQ2Nk5oQXR5NThTZmhlMXZWajlsYlZweGtqTzBsbDhxM3Y1a1VBY2JDVG1m?=
 =?utf-8?Q?/xyva/BpfGQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWVockhrVVRpOU11YVlOOFRJZmxKNndLbE9Kb21tWUh6OFpMQjZ0ZHBDZzJr?=
 =?utf-8?B?RFNZWEFVWjhTUk5SQlIxelpPNklHcGd6akI4alpZWGxpVm52ZHJWVDhXdmI0?=
 =?utf-8?B?NTBpTmFMcEpTN1NCdDlJd1hpRVRaUVk1K0o5S3ZDVlRKQ2k3ZDhlVmVHOHF0?=
 =?utf-8?B?bTFVVUI3NVMyaG1EU0UxMTFSK3pzVUo3VU00aXh6dTZ0KzJOT2dMcjVLdHVw?=
 =?utf-8?B?c2crOFkvRGdCbnVsdFJzdWs0d1dTc2hxVjRzWG55ckNZZllTU0Zuem5ta3kr?=
 =?utf-8?B?KzdXdmtVQ29tWTc1UHMwWWtXME9hS1NzMlpjNERpOWVFN1ZPaVd0MFc5cU1i?=
 =?utf-8?B?Z3lMOXU0QjE1YXFZUjV1NStGZGZWU0F0NkprZVBBbW84SFd1eFVneXNxS2cw?=
 =?utf-8?B?djAvN0dkbWowOE1DWlhwL1RSYTgvWk1oMjV0akN2YVVkZEQ3cjVqeFpEaVBn?=
 =?utf-8?B?TkJOcis0MFlFeStpUlpXUzk3V1U5Ylh3cXY3RWt1c1VXWms2aU1TbmZlSXNC?=
 =?utf-8?B?SnNKSEhIUkN4NXAySmdoLzRXT2VOMStnYmZHd3F2L1d4TGxmNHI4UDRTM21D?=
 =?utf-8?B?cDZVZ3BFNzhZS0hDOFgyLzdpRTQvMm4zVG42dVRsQU1FUGdFemNzenlQbVgr?=
 =?utf-8?B?OVJtbTZWQlB3Tk9kd2s3UUNpZjVJS3oydWd1QWg0WGlMYWJVTFl0WVF6UHZ5?=
 =?utf-8?B?dG0xMTZnVGtyMVJ3L1JtYTBCRFZXMDF4ZFc2ekc0a01tYVI3ckRJRGY2ejFM?=
 =?utf-8?B?QnZHc0Y3WDZwU0dVTGRsZHlVMS9nbGpBTnJxeWhsaHkyMERaSTRSYmdBZWU0?=
 =?utf-8?B?Y0RsbEdmYWdHNy9YeVd3TVdrSldsTS9ISXZkSXJqNEFaSEFPRmE0bUpXMzhp?=
 =?utf-8?B?SGxJZnMvelhWbzR4NzBJeXk4UHcxT09qUzVUR2NoU2VlMEFrNVlpNjdZdVN2?=
 =?utf-8?B?ZkU1MFA0azA2MDhSYnovaHJhbXYvQnJnaS9taEdibUVrZXAzb1JrbXVJK1Ni?=
 =?utf-8?B?NnFtWHB6bm95MHFDRkFrc1BheDFERDF4R3VTbVhuczBMVHpjaUhreWhwVnlT?=
 =?utf-8?B?b0ZpRzRIOE4zQUptbXFvZ0lnZkl6VEY1ME9IS0hPY2Y3K3hyODl5Q3doRTBn?=
 =?utf-8?B?cTNSR3V3UWtBeXcva2F5MDFXMVdFZmZRK2ZNNnQ2dzNqdXJpZ3FuUkM2ejcw?=
 =?utf-8?B?Zjkxa0d5NmlPY3N5UFVra0tmR1JNaVVRalNGWVFxWVFXZlZvUWhnOUE4cWpz?=
 =?utf-8?B?Smd4NFp0c0RlSTh3VVpwTEg2UG1xV21NdFh2UURSTllGMUt2cHMxaFNTSThy?=
 =?utf-8?B?MWtkNDgzM0NKVWZDYWhxU1VCRGg2WXRIY1dRbzRvdjM4NGhTbDZjdGZTVW04?=
 =?utf-8?B?dkJySUNxZjVMUWMrYW05K21naWtMWGV2b2pSUnNadGhXaG9aUnZGQTM3aFV5?=
 =?utf-8?B?TDUwaXZDaStNRnR4ay8xM044STJ3enF0NzZQVThGK2hkcjJLYmZSMjFYK2FH?=
 =?utf-8?B?MzlScStZRnlwaGRIemxCSDZ6RHVuSzd4Kys0T3JmL0Fodm9lZW1JUWprTGht?=
 =?utf-8?B?bzRVc2c2RG9EbzY1NjhaNGhqQ0lBSEZMYkhxSE5zbHo1Ym85VVJCTkg2S2pm?=
 =?utf-8?B?b0E2VGRvWGJPNGNnbW92aThGNVI5Zm95RFpaUndvTFVPZ0h6TldXME9HT09F?=
 =?utf-8?B?UTl3V3RkQk9McERLeU1zUEdZV0liSDg4dUNkQzBwRU9OODZnUnNjamxOSFRh?=
 =?utf-8?B?ZnlRclRmbXJORVExdERVeHM1ZmdBZlh3WmFuTmhNMjBPL0lrNFBmSkxkNTJk?=
 =?utf-8?B?SXU1N044elY5eXhZL3BlZTJHOGtHMExtNHpMdlFzc2E4UDIxRHRkVHZyQ3pQ?=
 =?utf-8?B?aXRTTG1Lb3NPb0ZWckRvNXk3VWpuQTV5UGdEOU1NUmRlTGNpajR4elA5akh4?=
 =?utf-8?B?dVZIOEZuK2plY2RjUnZwYmN0MmdCdU1oY0RPQTlqZDdmaWpsWklLSm1zUita?=
 =?utf-8?B?WVZpSlJ1NjYwaWlJYWlvWUhFMDdUUUNYRnJ0UHljdTJiTDUvTzdYTC9VU1k4?=
 =?utf-8?B?aXZmUTZISUlNWW9EZHNFZEt5a1ppQjcrazIzM1QvOHlmZGo0ZkYydEpOSG5B?=
 =?utf-8?Q?/o18IyFiWRtIHn5HJitHqAZTz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440395fc-a8e4-4569-8210-08dd36d4f6b9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 08:57:25.9211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rm7ubM0OGr7b/Rh60q4PhvMI0SSofBBqYyc/4gjtp0hmOlx5WL/62Rp9WaOyDH+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445
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



On 1/13/2025 7:12 AM, Jiang Liu wrote:
> Convert ip block bool flags into an enumeration, to explicitly mark
> current state of the ip block. Also introduce helper functions to
> manipulate the ip block state. Now the state machine works as below:
> Callbacks                    State after successfully execute callback
>                              AMDGPU_IP_STATE_INVALID
> .early_init()                AMDGPU_IP_STATE_EARLY
> .sw_init()                   AMDGPU_IP_STATE_SW
> .hw_init()                   AMDGPU_IP_STATE_HW
> .late_init()                 AMDGPU_IP_STATE_LATE
> .early_fini()                AMDGPU_IP_STATE_HW
> .hw_fini()                   AMDGPU_IP_STATE_SW
> .sw_fini()                   AMDGPU_IP_STATE_EARLY
> .late_fini()                 AMDGPU_IP_STATE_INVALID
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c      |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  48 ++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 144 ++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |   6 +-
>  drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c |   2 +-
>  drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   |   2 +-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c   |   2 +-
>  9 files changed, 143 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index e13fbd974141..b2bad8837b64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -301,7 +301,7 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
>  				return r;
>  			}
>  		}
> -		adev->ip_blocks[i].status.late_initialized = true;
> +		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_LATE);
>  	}
>  
>  	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 24ef39b706e3..f3275a281280 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -395,11 +395,32 @@ enum amdgpu_marker {
>  
>  #define AMDGPU_MARKER_IRQ(idx)		(AMDGPU_MARKER_IRQ0 + (idx))
>  
> +/**
> + * States for ip block state machine.
> + *
> + * The IP block state machine has five states and the associated state
> + * transition works in stack like way as below:
> + * Callbacks			State after successfully execute callback
> + *				AMDGPU_IP_STATE_INVALID
> + * .early_init()		AMDGPU_IP_STATE_EARLY
> + * .sw_init()			AMDGPU_IP_STATE_SW
> + * .hw_init()			AMDGPU_IP_STATE_HW
> + * .late_init()			AMDGPU_IP_STATE_LATE
> + * .early_fini()		AMDGPU_IP_STATE_HW
> + * .hw_fini()			AMDGPU_IP_STATE_SW
> + * .sw_fini()			AMDGPU_IP_STATE_EARLY
> + * .late_fini()			AMDGPU_IP_STATE_INVALID
> + */
> +enum amdgpu_device_ip_state {
> +	AMDGPU_IP_STATE_INVALID	= 0,
> +	AMDGPU_IP_STATE_EARLY	= 1,
> +	AMDGPU_IP_STATE_SW	= 2,
> +	AMDGPU_IP_STATE_HW	= 3,
> +	AMDGPU_IP_STATE_LATE	= 4,

Would suggest to add separate INIT/FINI stages for each state -
EARLY_INIT_DONE/EARLY_FINI_DONE. Then reading the code will be easier.

Thanks,
Lijo

> +};
> +
>  struct amdgpu_ip_block_status {
> -	bool valid;
> -	bool sw;
> -	bool hw;
> -	bool late_initialized;
> +	enum amdgpu_device_ip_state state;
>  	bool hang;
>  	uint64_t markers;
>  };
> @@ -429,6 +450,25 @@ amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
>  int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
>  			       const struct amdgpu_ip_block_version *ip_block_version);
>  
> +void amdgpu_device_ip_set_state(struct amdgpu_device *adev, int index,
> +				enum amdgpu_device_ip_state state);
> +enum amdgpu_device_ip_state amdgpu_device_ip_state(struct amdgpu_device *adev,
> +						   int index);
> +bool amdgpu_device_ip_valid(struct amdgpu_device *adev, int index);
> +void amdgpu_ip_block_set_state(struct amdgpu_ip_block *ip_block,
> +			       enum amdgpu_device_ip_state state);
> +
> +static inline enum amdgpu_device_ip_state
> +amdgpu_ip_block_state(struct amdgpu_ip_block *ip_block)
> +{
> +	return ip_block->status.state;
> +}
> +
> +static inline bool amdgpu_ip_block_valid(struct amdgpu_ip_block *ip_block)
> +{
> +	return ip_block->status.state != AMDGPU_IP_STATE_INVALID;
> +}
> +
>  static inline void amdgpu_ip_block_set_marker(struct amdgpu_ip_block *ip_block,
>  					      enum amdgpu_marker marker)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c2e4057ecd82..fcfbdcfd1fa3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -297,7 +297,7 @@ int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block)
>  		}
>  	}
>  
> -	ip_block->status.hw = false;
> +	amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_SW);
>  	return 0;
>  }
>  
> @@ -315,7 +315,7 @@ int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block)
>  		}
>  	}
>  
> -	ip_block->status.hw = true;
> +	amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_HW);
>  	return 0;
>  }
>  
> @@ -2164,7 +2164,7 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
>  	int i, r = 0;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> +		if (!amdgpu_device_ip_valid(adev, i))
>  			continue;
>  		if (adev->ip_blocks[i].version->type != block_type)
>  			continue;
> @@ -2198,7 +2198,7 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
>  	int i, r = 0;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> +		if (!amdgpu_device_ip_valid(adev, i))
>  			continue;
>  		if (adev->ip_blocks[i].version->type != block_type)
>  			continue;
> @@ -2230,7 +2230,7 @@ void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
>  	int i;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> +		if (!amdgpu_device_ip_valid(adev, i))
>  			continue;
>  		if (adev->ip_blocks[i].version->funcs->get_clockgating_state)
>  			adev->ip_blocks[i].version->funcs->get_clockgating_state((void *)adev, flags);
> @@ -2252,7 +2252,7 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
>  	int i, r;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> +		if (!amdgpu_device_ip_valid(adev, i))
>  			continue;
>  		if (adev->ip_blocks[i].version->type == block_type) {
>  			if (adev->ip_blocks[i].version->funcs->wait_for_idle) {
> @@ -2284,7 +2284,7 @@ bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
>  		if (adev->ip_blocks[i].version->type == block_type)
> -			return adev->ip_blocks[i].status.valid;
> +			return amdgpu_device_ip_valid(adev, i);
>  	}
>  	return false;
>  
> @@ -2375,6 +2375,29 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> +void amdgpu_device_ip_set_state(struct amdgpu_device *adev, int index,
> +			       enum amdgpu_device_ip_state state)
> +{
> +	amdgpu_ip_block_set_state(&adev->ip_blocks[index], state);
> +}
> +
> +enum amdgpu_device_ip_state amdgpu_device_ip_state(struct amdgpu_device *adev,
> +						 int index)
> +{
> +	return amdgpu_ip_block_state(&adev->ip_blocks[index]);
> +}
> +
> +bool amdgpu_device_ip_valid(struct amdgpu_device *adev, int index)
> +{
> +	return amdgpu_ip_block_valid(&adev->ip_blocks[index]);
> +}
> +
> +void amdgpu_ip_block_set_state(struct amdgpu_ip_block *ip_block,
> +			       enum amdgpu_device_ip_state state)
> +{
> +	ip_block->status.state = state;
> +}
> +
>  /**
>   * amdgpu_device_enable_virtual_display - enable virtual display feature
>   *
> @@ -2671,20 +2694,21 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>  		if ((amdgpu_ip_block_mask & (1 << i)) == 0) {
>  			DRM_WARN("disabled ip block: %d <%s>\n",
>  				  i, adev->ip_blocks[i].version->funcs->name);
> -			adev->ip_blocks[i].status.valid = false;
> +			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_INVALID);
>  		} else if (ip_block->version->funcs->early_init) {
>  			r = ip_block->version->funcs->early_init(ip_block);
>  			if (r == -ENOENT) {
> -				adev->ip_blocks[i].status.valid = false;
> +				amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_INVALID);
>  			} else if (r) {
>  				DRM_ERROR("early_init of IP block <%s> failed %d\n",
>  					  adev->ip_blocks[i].version->funcs->name, r);
>  				total = false;
> +				amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_INVALID);
>  			} else {
> -				adev->ip_blocks[i].status.valid = true;
> +				amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_EARLY);
>  			}
>  		} else {
> -			adev->ip_blocks[i].status.valid = true;
> +			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_EARLY);
>  		}
>  		/* get the vbios after the asic_funcs are set up */
>  		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
> @@ -2715,7 +2739,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>  		return -ENODEV;
>  
>  	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
> -	if (ip_block->status.valid != false)
> +	if (amdgpu_ip_block_valid(ip_block))
>  		amdgpu_amdkfd_device_probe(adev);
>  
>  	adev->cg_flags &= amdgpu_cg_mask;
> @@ -2729,9 +2753,9 @@ static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
>  	int i, r;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.sw)
> +		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_SW)
>  			continue;
> -		if (adev->ip_blocks[i].status.hw)
> +		if (amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
>  			continue;
>  		if (!amdgpu_ip_member_of_hwini(
>  			    adev, adev->ip_blocks[i].version->type))
> @@ -2745,7 +2769,7 @@ static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
>  					  adev->ip_blocks[i].version->funcs->name, r);
>  				return r;
>  			}
> -			adev->ip_blocks[i].status.hw = true;
> +			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
>  		}
>  	}
>  
> @@ -2757,9 +2781,9 @@ static int amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
>  	int i, r;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.sw)
> +		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_SW)
>  			continue;
> -		if (adev->ip_blocks[i].status.hw)
> +		if (amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
>  			continue;
>  		if (!amdgpu_ip_member_of_hwini(
>  			    adev, adev->ip_blocks[i].version->type))
> @@ -2770,7 +2794,7 @@ static int amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
>  				  adev->ip_blocks[i].version->funcs->name, r);
>  			return r;
>  		}
> -		adev->ip_blocks[i].status.hw = true;
> +		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
>  	}
>  
>  	return 0;
> @@ -2791,11 +2815,11 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>  						       AMD_IP_BLOCK_TYPE_PSP))
>  				break;
>  
> -			if (!adev->ip_blocks[i].status.sw)
> +			if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_SW)
>  				continue;
>  
>  			/* no need to do the fw loading again if already done*/
> -			if (adev->ip_blocks[i].status.hw == true)
> +			if (amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
>  				break;
>  
>  			if (amdgpu_in_reset(adev) || adev->in_suspend) {
> @@ -2809,7 +2833,7 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>  							  adev->ip_blocks[i].version->funcs->name, r);
>  					return r;
>  				}
> -				adev->ip_blocks[i].status.hw = true;
> +				amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
>  			}
>  			break;
>  		}
> @@ -2900,7 +2924,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  		return r;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> +		if (!amdgpu_device_ip_valid(adev, i))
>  			continue;
>  		if (adev->ip_blocks[i].version->funcs->sw_init) {
>  			r = adev->ip_blocks[i].version->funcs->sw_init(&adev->ip_blocks[i]);
> @@ -2910,7 +2934,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  				goto init_failed;
>  			}
>  		}
> -		adev->ip_blocks[i].status.sw = true;
> +		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_SW);
>  
>  		if (!amdgpu_ip_member_of_hwini(
>  			    adev, adev->ip_blocks[i].version->type))
> @@ -2923,7 +2947,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  				DRM_ERROR("hw_init %d failed %d\n", i, r);
>  				goto init_failed;
>  			}
> -			adev->ip_blocks[i].status.hw = true;
> +			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
>  		} else if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
>  			/* need to do gmc hw init early so we can allocate gpu mem */
>  			/* Try to reserve bad pages early */
> @@ -2945,7 +2969,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  				DRM_ERROR("amdgpu_device_wb_init failed %d\n", r);
>  				goto init_failed;
>  			}
> -			adev->ip_blocks[i].status.hw = true;
> +			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
>  
>  			/* right after GMC hw init, we create CSA */
>  			if (adev->gfx.mcbp) {
> @@ -3130,7 +3154,7 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
>  
>  	for (j = 0; j < adev->num_ip_blocks; j++) {
>  		i = state == AMD_CG_STATE_GATE ? j : adev->num_ip_blocks - j - 1;
> -		if (!adev->ip_blocks[i].status.late_initialized)
> +		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_LATE)
>  			continue;
>  		/* skip CG for GFX, SDMA on S0ix */
>  		if (adev->in_s0ix &&
> @@ -3167,7 +3191,7 @@ int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
>  
>  	for (j = 0; j < adev->num_ip_blocks; j++) {
>  		i = state == AMD_PG_STATE_GATE ? j : adev->num_ip_blocks - j - 1;
> -		if (!adev->ip_blocks[i].status.late_initialized)
> +		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_LATE)
>  			continue;
>  		/* skip PG for GFX, SDMA on S0ix */
>  		if (adev->in_s0ix &&
> @@ -3246,7 +3270,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
>  	int i = 0, r;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.hw)
> +		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_HW)
>  			continue;
>  		if (adev->ip_blocks[i].version->funcs->late_init) {
>  			r = adev->ip_blocks[i].version->funcs->late_init(&adev->ip_blocks[i]);
> @@ -3256,7 +3280,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
>  				return r;
>  			}
>  		}
> -		adev->ip_blocks[i].status.late_initialized = true;
> +		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_LATE);
>  	}
>  
>  	r = amdgpu_ras_late_init(adev);
> @@ -3336,7 +3360,7 @@ static void amdgpu_ip_block_hw_fini(struct amdgpu_ip_block *ip_block)
>  		}
>  	}
>  
> -	ip_block->status.hw = false;
> +	amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_SW);
>  }
>  
>  /**
> @@ -3354,7 +3378,7 @@ static void amdgpu_device_smu_fini_early(struct amdgpu_device *adev)
>  		return;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.hw)
> +		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_HW)
>  			continue;
>  		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
>  			amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
> @@ -3377,7 +3401,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>  				  adev->ip_blocks[i].version->funcs->name, r);
>  		}
>  
> -		adev->ip_blocks[i].status.late_initialized = false;
> +		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
>  	}
>  
>  	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> @@ -3389,7 +3413,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>  	amdgpu_device_smu_fini_early(adev);
>  
>  	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
> -		if (!adev->ip_blocks[i].status.hw)
> +		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_HW)
>  			continue;
>  
>  		amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
> @@ -3427,7 +3451,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>  	amdgpu_amdkfd_device_fini_sw(adev);
>  
>  	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
> -		if (!adev->ip_blocks[i].status.sw)
> +		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_SW)
>  			continue;
>  
>  		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
> @@ -3446,17 +3470,17 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>  					  adev->ip_blocks[i].version->funcs->name, r);
>  			}
>  		}
> -		adev->ip_blocks[i].status.sw = false;
> +		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_EARLY);
>  	}
>  
>  	amdgpu_ras_fini(adev);
>  
>  	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
> -		if (!adev->ip_blocks[i].status.valid)
> +		if (!amdgpu_device_ip_valid(adev, i))
>  			continue;
>  		if (adev->ip_blocks[i].version->funcs->late_fini)
>  			adev->ip_blocks[i].version->funcs->late_fini(&adev->ip_blocks[i]);
> -		adev->ip_blocks[i].status.valid = false;
> +		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_INVALID);
>  	}
>  
>  	return 0;
> @@ -3517,9 +3541,9 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>  		dev_warn(adev->dev, "Failed to disallow df cstate");
>  
>  	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
> -		if (!adev->ip_blocks[i].status.valid)
> +		if (!amdgpu_device_ip_valid(adev, i))
>  			continue;
> -		if (!adev->ip_blocks[i].status.late_initialized)
> +		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_LATE)
>  			continue;
>  
>  		if (adev->ip_blocks[i].version->funcs->early_fini) {
> @@ -3531,11 +3555,11 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>  			}
>  		}
>  
> -		adev->ip_blocks[i].status.late_initialized = false;
> +		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
>  	}
>  
>  	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
> -		if (!adev->ip_blocks[i].status.valid)
> +		if (!amdgpu_device_ip_valid(adev, i))
>  			continue;
>  
>  		/* displays are handled separately */
> @@ -3570,7 +3594,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>  		amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D3Entry);
>  
>  	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
> -		if (!adev->ip_blocks[i].status.valid)
> +		if (!amdgpu_device_ip_valid(adev, i))
>  			continue;
>  		/* displays are handled in phase1 */
>  		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE)
> @@ -3578,7 +3602,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>  		/* PSP lost connection when err_event_athub occurs */
>  		if (amdgpu_ras_intr_triggered() &&
>  		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP) {
> -			adev->ip_blocks[i].status.hw = false;
> +			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_SW);
>  			continue;
>  		}
>  
> @@ -3620,7 +3644,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>  
>  		/* XXX handle errors */
>  		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
> -		adev->ip_blocks[i].status.hw = false;
> +		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_SW);
>  
>  		/* handle putting the SMC in the appropriate state */
>  		if (!amdgpu_sriov_vf(adev)) {
> @@ -3687,12 +3711,12 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>  		struct amdgpu_ip_block *block;
>  
>  		block = &adev->ip_blocks[i];
> -		block->status.hw = false;
> +		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_SW);
>  
>  		for (j = 0; j < ARRAY_SIZE(ip_order); j++) {
>  
>  			if (block->version->type != ip_order[j] ||
> -				!block->status.valid)
> +			    !amdgpu_device_ip_valid(adev, i))
>  				continue;
>  
>  			r = block->version->funcs->hw_init(&adev->ip_blocks[i]);
> @@ -3701,7 +3725,7 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>  					 block->version->funcs->name);
>  				return r;
>  			}
> -			block->status.hw = true;
> +			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
>  		}
>  	}
>  
> @@ -3731,7 +3755,8 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
>  		if (!block)
>  			continue;
>  
> -		if (block->status.valid && !block->status.hw) {
> +		if (amdgpu_ip_block_valid(block) &&
> +		    amdgpu_ip_block_state(block) < AMDGPU_IP_STATE_HW) {
>  			if (block->version->type == AMD_IP_BLOCK_TYPE_SMC) {
>  				r = amdgpu_ip_block_resume(block);
>  			} else {
> @@ -3743,7 +3768,7 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
>  					 block->version->funcs->name);
>  				break;
>  			}
> -			block->status.hw = true;
> +			amdgpu_ip_block_set_state(block, AMDGPU_IP_STATE_HW);
>  		}
>  	}
>  
> @@ -3767,7 +3792,8 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
>  	int i, r;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
> +		if (!amdgpu_device_ip_valid(adev, i) ||
> +		    amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
>  			continue;
>  		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>  		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
> @@ -3801,7 +3827,8 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
>  	int i, r;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
> +		if (!amdgpu_device_ip_valid(adev, i) ||
> +		    amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
>  			continue;
>  		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>  		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
> @@ -3835,7 +3862,8 @@ static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
>  	int i, r;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
> +		if (!amdgpu_device_ip_valid(adev, i) ||
> +		    amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
>  			continue;
>  		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
>  			r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
> @@ -4888,7 +4916,7 @@ int amdgpu_device_prepare(struct drm_device *dev)
>  	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> +		if (!amdgpu_device_ip_valid(adev, i))
>  			continue;
>  		if (!adev->ip_blocks[i].version->funcs->prepare_suspend)
>  			continue;
> @@ -5090,7 +5118,7 @@ static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev)
>  		return true;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> +		if (!amdgpu_device_ip_valid(adev, i))
>  			continue;
>  		if (adev->ip_blocks[i].version->funcs->check_soft_reset)
>  			adev->ip_blocks[i].status.hang =
> @@ -5120,7 +5148,7 @@ static int amdgpu_device_ip_pre_soft_reset(struct amdgpu_device *adev)
>  	int i, r = 0;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> +		if (!amdgpu_device_ip_valid(adev, i))
>  			continue;
>  		if (adev->ip_blocks[i].status.hang &&
>  		    adev->ip_blocks[i].version->funcs->pre_soft_reset) {
> @@ -5150,7 +5178,7 @@ static bool amdgpu_device_ip_need_full_reset(struct amdgpu_device *adev)
>  		return true;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> +		if (!amdgpu_device_ip_valid(adev, i))
>  			continue;
>  		if ((adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) ||
>  		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) ||
> @@ -5182,7 +5210,7 @@ static int amdgpu_device_ip_soft_reset(struct amdgpu_device *adev)
>  	int i, r = 0;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> +		if (!amdgpu_device_ip_valid(adev, i))
>  			continue;
>  		if (adev->ip_blocks[i].status.hang &&
>  		    adev->ip_blocks[i].version->funcs->soft_reset) {
> @@ -5211,7 +5239,7 @@ static int amdgpu_device_ip_post_soft_reset(struct amdgpu_device *adev)
>  	int i, r = 0;
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> +		if (!amdgpu_device_ip_valid(adev, i))
>  			continue;
>  		if (adev->ip_blocks[i].status.hang &&
>  		    adev->ip_blocks[i].version->funcs->post_soft_reset)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f908355df07c..33030a0bfef2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -515,7 +515,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  
>  	for (i = 0; i < adev->num_ip_blocks; i++)
>  		if (adev->ip_blocks[i].version->type == type &&
> -		    adev->ip_blocks[i].status.valid)
> +		    amdgpu_device_ip_valid(adev, i))
>  			break;
>  
>  	if (i == adev->num_ip_blocks)
> @@ -636,7 +636,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		type = amdgpu_ip_get_block_type(adev, info->query_hw_ip.type);
>  		ip_block = amdgpu_device_ip_get_ip_block(adev, type);
>  
> -		if (!ip_block || !ip_block->status.valid)
> +		if (!ip_block || !amdgpu_ip_block_valid(ip_block))
>  			return -EINVAL;
>  
>  		if (adev->xcp_mgr && adev->xcp_mgr->num_xcps > 0 &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index a441dffca45b..26a0d9050dca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3897,7 +3897,8 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
>  	int ret;
>  
>  	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP);
> -	if (!ip_block || !ip_block->status.late_initialized) {
> +	if (!ip_block ||
> +	    amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_LATE) {
>  		dev_info(adev->dev, "PSP block is not ready yet\n.");
>  		return -EBUSY;
>  	}
> @@ -3929,7 +3930,8 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
>  	struct amdgpu_ip_block *ip_block;
>  
>  	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP);
> -	if (!ip_block || !ip_block->status.late_initialized) {
> +	if (!ip_block ||
> +	    amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_LATE) {
>  		dev_err(adev->dev, "PSP block is not ready yet.");
>  		return -EBUSY;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index dabfbdf6f1ce..eb72dac61c83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -31,9 +31,9 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>  	int i;
>  
>  	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
> -		if (!adev->ip_blocks[i].status.valid)
> +		if (!amdgpu_device_ip_valid(adev, i))
>  			continue;
> -		if (!adev->ip_blocks[i].status.hw)
> +		if (amdgpu_device_ip_state(adev, i) <= AMDGPU_IP_STATE_HW)
>  			continue;
>  		/* displays are handled in phase1 */
>  		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE)
> @@ -41,7 +41,7 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>  
>  		/* XXX handle errors */
>  		amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
> -		adev->ip_blocks[i].status.hw = false;
> +		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_SW);
>  	}
>  
>  	/* VCN FW shared region is in frambuffer, there are some flags
> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> index 2594467bdd87..c9479a92a9df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> @@ -204,7 +204,7 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
>  				return r;
>  			}
>  		}
> -		adev->ip_blocks[i].status.late_initialized = true;
> +		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_LATE);
>  	}
>  
>  	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> index 70569ea906bc..75dc5cb1e1ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> @@ -205,7 +205,7 @@ static int smu_v13_0_10_mode2_restore_ip(struct amdgpu_device *adev)
>  				return r;
>  			}
>  		}
> -		adev->ip_blocks[i].status.late_initialized = true;
> +		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_LATE);
>  	}
>  
>  	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8ca793c222ff..c75402d606c3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -230,7 +230,7 @@ static bool is_vcn_enabled(struct amdgpu_device *adev)
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
>  		if ((adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_VCN ||
>  			adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_JPEG) &&
> -			!adev->ip_blocks[i].status.valid)
> +			!amdgpu_device_ip_valid(adev, i))
>  			return false;
>  	}
>  

