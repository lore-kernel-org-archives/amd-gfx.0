Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E028CF8545
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 06:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E8D710E108;
	Thu, 20 Nov 2025 06:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GYauVXk/";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C4610E108
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 06:29:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oefYWG1tPevY9chYBBgODl4C/6+w01CPoekAJ1Yl9grxGLJfK++t1cuSVAgZQ41ph+4h2mBFC5etlqQP7/JBXZOAMO+bzTlk9/3s3bAceZnURnsOocJltmCCM5BO93vMKC2MbwH2DE0KtRjWwnffUf8zCOPZxK7AdfOQZZYGOaWneoB0uoLd6lMGdsrytM/zOhAYPVUBgUyERAnxLisolh+ZtSEdbqOwStE0g02Qd6n2txGxkj3Ihguvx0HFzP1EbvH3e/ixiXnUqxoDn+EsajutA1DbRYwQASZJV5lBesvPk3Eofq4kQDf8PtyYpyMjjdI5r69Y+rarxdKH7Sjekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLY4xqvIQGTc0/4JmS7YYVLWA35oNwEhmCUDTiOc2j4=;
 b=dh+vrAkNQ043AUKilFHElUfiFJdn+9uMxL3K0uLxpo9HvcqXM5tbqE1WKcC/wWCfwi1b6x8EIYnFW4yijjS4GLThwRibpvw+ZuAX6nMI4NukMe9cJngJAo8biEwHsu8FDP2q40fDtigZ1RBzfGltYogTNXhVron1vbZkr3N7ld2/xOx/NMTRm52ID9jgY9zqB3Y3ge5Ht3+njzMsWuMcofa6VQ441qDYaAlsyhtWxRlosIVnt3ppMazS53Jxlj0RuJqRHqqDW0BMFRR1h76ridZMvBnP6IlkPvEePL8VromYANVfMPYR/3lX0ZZVZuysZywZc/tNJMsAqyncNzjNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLY4xqvIQGTc0/4JmS7YYVLWA35oNwEhmCUDTiOc2j4=;
 b=GYauVXk/pEH10C7HfoPXmKHRdpjziGB284yvavyDqVVkPMVa71J7i16xyuMk4GOpbmey9w60bsvYkHpiyRFBtvsWP+fCW68SYwu3ZS76geWRm23gcsWEiXO+IWPQs7o6yRrDXJrd5izCTEfPp8M++N78o+DAZR1gBAdhRr9wdmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Thu, 20 Nov
 2025 06:29:00 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 06:28:59 +0000
Message-ID: <7d213252-4d1e-4192-b7d5-c99406531b91@amd.com>
Date: Thu, 20 Nov 2025 11:58:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: fix amdgpu_irq enabled counter unbalanced
 on smu v11.0
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com, candice.li@amd.com
References: <20251120023308.2628705-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251120023308.2628705-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0032.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW4PR12MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 4425e71a-1358-4d29-2dd5-08de27fe16ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnZGMTdyTGJQczJ5MlNXdkprUDI1ai9oc1RyaW1naHM5VktHR1BmbmdjRm1W?=
 =?utf-8?B?azRuOENKUWJLYys1M0doYVNNVXBrNE05RHZ5bG5ibE9xT3F5L3JjbHNzNnlV?=
 =?utf-8?B?Rlo5VTVLYjJzUVhrc0hxOUNrbmpyZnlXRjJnWjlCcVlTbElDWmVsVmRiWGpL?=
 =?utf-8?B?WXdSU1hJT3h6UWJFbmRncEowMGYwdTZLUVFRS3Iyc1dGODhtOE9rNC9EZ2xa?=
 =?utf-8?B?U0ZNYVFpWHg4MlI3RXh0U3BuYitTL2NyMEdwaEhVWEhFUzFYZmNJTVRka2ts?=
 =?utf-8?B?ZkIwK0RIZUxsU25Ya1Q0MG1TL0Z0MFA3L3ZjcHZ0QTZPR216cXozK1dWVlJz?=
 =?utf-8?B?VWorVWQrRVVJRDlOdWlZTk8zU3NUVlM4ZkQveERWTFM0dGlQTVRtcHJkUkxS?=
 =?utf-8?B?N2pITEU2T2kySW5ySVJMWlhzMWEyeDFDVU1tRVllcjQrTFlzNWw0R21TRXRX?=
 =?utf-8?B?K216by9SWU0veURGdmZLa3U2d2RQUUJISHJLS3RXVmtWR2RkdGNmanJNRVBU?=
 =?utf-8?B?Kzc4c09EbDdadVFSQ3cvYWprd3V5bXZCR0UxeW0wQ0tjRVB2MVJ1UGh6RVRr?=
 =?utf-8?B?TFZvLy84bjV6ZFFWd0plTHZCSjRJV1dwdVE1QTM1cEtIbmJvNGk4OTNzcjJy?=
 =?utf-8?B?djlCQnRXU2FOQ0JCTVVMZC94VzVuTTVSSWZqNkprSGlxRkRVQ2FjNTZpamJ5?=
 =?utf-8?B?OFZlWEF6eEtVdmNGcU01dTNUQlVjQVdoR0RZSlVPKzJoaFhBcEpLdDhOdFVz?=
 =?utf-8?B?SGFRMkJWNndrTzY0dmNrL1F6OTArbzZLREhsS2RsbWhMSk1JZTRWME1vTGwx?=
 =?utf-8?B?cUFUOWorWDVIS3NBa3ZaZVN6Z1dCbFhkSjVyZzdJVXdPMEtmM1hqOGpKZzlh?=
 =?utf-8?B?ZStQS0VTemFOV0M2ZTRLcGFReEF5SUdqVFdoTi83blpVbkFUKzVoNzc3K3cx?=
 =?utf-8?B?U1U3MUFvUnd2ZXU3azM4N3RyM3c2U2ZhalduclpzanBFTnJHakxROS80MTVw?=
 =?utf-8?B?ODcyYm8wSTErT0RacjRXdjhGb1MvRDN6YVExOFFrSTl6ZnpIVVBwV29YbWpC?=
 =?utf-8?B?c1hkZkFURjEvVVhtRzlxdzd1Y0VRRnNBc05XSHBjalBDczlmWSt5dU11L2F5?=
 =?utf-8?B?ems2ckdPV1lFMTI1d3NNRnlRUjh3MmtxMGRPdFNUbE96QlRqdFlwSVlrZTRn?=
 =?utf-8?B?SWtUUTVVcTg4WHIrelVKQkZTNjNPU3FiVVhQa3Q5anZEUEhxUklLK1RjSFE0?=
 =?utf-8?B?SjFFN2liczRWVFhvNmNaMzNmcVZXTWVCQUtRTWJ0bkVxUzdJSUxhbytTTHhj?=
 =?utf-8?B?TFd2MVIwcjRmcEQrZmthdVlEMTh6cDFUeEhzVGJCTVdOLzVMbjRvNVJqNGJK?=
 =?utf-8?B?ZWVrZUtCSTUreTBRajFSYmNxYkQ2enVkZDltc0MzVGdsVkdmV2pYRTNaQTVl?=
 =?utf-8?B?Lzk3ZE1vRzgxOTcvQUd5UlE0MlpaUFBiMTRkM24rdmE1aHRGeFFrbmc3bStJ?=
 =?utf-8?B?dldIakl5NnVPUkE0VDNwQUljMHhSeklSV01LdlpQTG50cHhQSG1MdXdNQ0RG?=
 =?utf-8?B?aWg1UzI1OEdjOWRZOWtkaHlzdG1GU0ZxN0RpY09sR0hacmp4amxRUjlqRWY0?=
 =?utf-8?B?a0NxM1RUclJMVG5GU0NUaTZMbXI1Tm5hZ040TTIzcVRwQUdFbEJhdmZQdGlD?=
 =?utf-8?B?YzdXQ1FjMzZmVGpXbWJaOFhteVdUaTdWbnFlWDlWckJYb0xCVEE4MTI5a2lx?=
 =?utf-8?B?Wk1qc1lTaS9QUGdsL05wWk5IbFdZZ3dQVFp6UjlrL0VSUVk1Wml2c3R1MnI3?=
 =?utf-8?B?SUJaRk83NGU5bkFzcDZlTDBhTWk0eGsreVdqS3J6VXJpc0I0SDMzWmk5TlVk?=
 =?utf-8?B?Y3R2bmxiRHBCSlJhNm8rODBONE1SbDQ2QlhtOTN6OGUrbVZoT2doWXI1SGt6?=
 =?utf-8?Q?qiqjNVTWlV9xWT5mKnRiEjykqTUSA1ZS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2tTRitxMW0rQ2hRemRvUllWdmI4WlJ1N0E4OHhqTGRWM3VkamlGRExXYkVD?=
 =?utf-8?B?UkRKbzJiS0FHWWFJU1JxQW9aaUw2ZWZMUWluR1FrTEpOU0djU0VOOEYzRDRj?=
 =?utf-8?B?eklxa1RZNG1PWDl5bklUdHg4ZElaajlpQUJxbEZJbG9LRE9yekZjY2tIVURz?=
 =?utf-8?B?cDJoWEp1L1dsNHZFaThYZ3ZhY25xemF4V1NPYkJxWkx6RTU2NVB2SHVSc3Bz?=
 =?utf-8?B?UEZCc0s4cmpaRVRyM0ZlMTdJaVFPaklvZVluSHZrR1hEL1dweThUQ2k1VU95?=
 =?utf-8?B?Q2lJNU5BOWt2ZzhpckR4TTBweldlWDgzWGdpWEhwVVJDTVVtQXYwTHBXT3p5?=
 =?utf-8?B?R00yUkJlUFNjL0Ntb2RLS0tCYW43WFRmazZNcENLVU1CMzFNcWpoeHZBeU5L?=
 =?utf-8?B?WGYyWTdJT2lWaDlJUm8xWWVRdmxwSUM0S0NlRkFUY3kwUll1RzdCcDNtcDVZ?=
 =?utf-8?B?allEYkkxZDRzQTh4bjFtd0NFNnpWeXBzaVZUcXp2aStzR1FGL0Uzc2VRTUJx?=
 =?utf-8?B?UXljQkE2d2RvTWhvOFJYVFhKTlFiR2lOVERwYmdBNGwxR1l0Wm9ob2IrUmFO?=
 =?utf-8?B?WWJGR0lrYjZuUWdLZThVaWEyZ0sxK0NObUloRjVGRTV1OG94bTBFYVZKTmdp?=
 =?utf-8?B?TFJaVUE3Z3NPazJEeC84TjFQcDgyM2xFR0Y4ZnM4dG1Xc2g2am5PeDhsSG90?=
 =?utf-8?B?aWtZc2pYN2FJZHpMM0kwMnIrQzluR0V2RkZzcG8zR2RxYTZkc3JwWnZUR3RQ?=
 =?utf-8?B?bGtpR2did3RZelRWMENIM3prQmE5SmJ3bHhNalNZZFk4aG1EZHRlbHM3YzFL?=
 =?utf-8?B?cTRSZG1CdGJlcmxlSy9xaVNKS2NjaEQwK1ZnK0RNY3lTRVdXbTBEUlMwaHk0?=
 =?utf-8?B?TUZjdGVFU0xqNlhxZEVqb0ZpMlFJMWl0VFZXMmZtZmlIVkMzVDdtVnhWU3ZW?=
 =?utf-8?B?UERHb1VYVWlmcFJhVnJiQm1vcEpTbFZKd2dhWVlQRHVuMm9OQ3p0b0YzZW96?=
 =?utf-8?B?d2hXb1pRNkZ3WG14OTFlWEhoZ3B6RSszam9iTVh4OWkyZXdCbk1sSHZRcnVi?=
 =?utf-8?B?ZC83UUJMSTJtdkhubkc4UnNlTFJXOGphUURBS2Z0Uk5CczY1LzNtUXFhRWpl?=
 =?utf-8?B?ZWtsS0tmdk1rTlJ0elEvaUVrNEV0V2hEbWJidkxyMGhRNERoelZMc2daMVVq?=
 =?utf-8?B?M2JmWmFxK3c2OGpJbzdVMXllWi9HUmIrTW5zTGtpSTR3L3IrM2REcVlZRUZB?=
 =?utf-8?B?TENGaUVWRVQ0RmNUa0EzUE1hUU1XTVFURy9kS25uanR4YUorQmxveWh2eE9y?=
 =?utf-8?B?UnlkZlYxbEZKbXpkQ0ptYndtTUtRWkFKbGUrQ1lHYWQ2SWdjd3lscThkZUdG?=
 =?utf-8?B?Nm1VZExzS2dBbEZxTURuL2RXbmZiVjJ6UkQ3Y0duQUFJTVBYbjJCWXFqaDRB?=
 =?utf-8?B?ZTBwajJkcSt4UjBjaVI1cjh3c3F1UWNNZERUVGFhTTA5SWMwYUcyN3ZtcHMr?=
 =?utf-8?B?dU1nN0dzZWNOT0swTGU5WmorTWRrUStJTFp5ZTRBbXRNR3hnK3VhdG92L2RI?=
 =?utf-8?B?aHRTSzhsK1lRdlJsUVlMNWR1b2FsRzNDNml3ek9ORnBQYUhsWnAyaXF3TjNy?=
 =?utf-8?B?bzNjWllHaDNudEF5bXV4MFJEWk1ZSlBGc2dUUmtweS85S1Q3NloxZWNPRVZs?=
 =?utf-8?B?N01OdVV4UXh4UEZ1c2FXdzd5TjQ3SXJJcEJmcjJTY1VWN2lNdUt5eUlncGZ3?=
 =?utf-8?B?OTVXaDZRNVBoTWFvZzFZK1dRQXM2UnZyWEpTYm9DWExRWTZBQTIrSjNrRnJK?=
 =?utf-8?B?R3VDaEJzREFxZTNCZVJTZElHU3M2V1I1WTZsVmg4ZGFBRHd3eHNHWjRub09n?=
 =?utf-8?B?bGk4WUpFRUZQTy9VSlJwK1BrMUdWQ2VjVmMyQXJwZFQ2dWx5MzEwM09ZdHYx?=
 =?utf-8?B?dXlNY3U0Q2cxbFhHc1F6b1FtNE4vQzZTYlkvRU9LMGE5bThSZktmNDNPNzdk?=
 =?utf-8?B?ODcwQXUrMXl3MnhyRUlub1JINGVUb0tNdmpybEFPRU1rd3pnelYwWnNQUW9s?=
 =?utf-8?B?UEg3STViY0dES2paT1RaS2plQjRKVGRQRzZlREtmbUQ1TWUxZHVOc0RLTkE2?=
 =?utf-8?Q?BcIqgKjySZkLNPulMW0Cltj3B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4425e71a-1358-4d29-2dd5-08de27fe16ed
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 06:28:59.7098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AV+i9q1dDNPr/hNHSNAlNFdqoAbkeKA0ftF8ts1W4pF1AmeykV2CIXJGkxwR8Dat
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
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



On 11/20/2025 8:03 AM, Yang Wang wrote:
> v1:
> - fix amdgpu_irq enabled counter unbalanced issue on smu_v11_0_disable_thermal_alert.
> 
> v2:
> - re-enable smu thermal alert to make amdgpu irq counter balance for smu v11.0 if in runpm state
> 
> [75582.361561] ------------[ cut here ]------------
> [75582.361565] WARNING: CPU: 42 PID: 533 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xd8/0xf0 [amdgpu]
> ...
> [75582.362211] Tainted: [E]=UNSIGNED_MODULE
> [75582.362214] Hardware name: GIGABYTE MZ01-CE0-00/MZ01-CE0-00, BIOS F14a 08/14/2020
> [75582.362218] Workqueue: pm pm_runtime_work
> [75582.362225] RIP: 0010:amdgpu_irq_put+0xd8/0xf0 [amdgpu]
> [75582.362556] Code: 31 f6 31 ff e9 c9 bf cf c2 44 89 f2 4c 89 e6 4c 89 ef e8 db fc ff ff 5b 41 5c 41 5d 41 5e 5d 31 d2 31 f6 31 ff e9 a8 bf cf c2 <0f> 0b eb c3 b8 fe ff ff ff eb 97 e9 84 e8 8b 00 0f 1f 84 00 00 00
> [75582.362560] RSP: 0018:ffffd50d51297b80 EFLAGS: 00010246
> [75582.362564] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> [75582.362568] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [75582.362570] RBP: ffffd50d51297ba0 R08: 0000000000000000 R09: 0000000000000000
> [75582.362573] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e72091d2008
> [75582.362576] R13: ffff8e720af80000 R14: 0000000000000000 R15: ffff8e720af80000
> [75582.362579] FS:  0000000000000000(0000) GS:ffff8e9158262000(0000) knlGS:0000000000000000
> [75582.362582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [75582.362585] CR2: 000074869d040c14 CR3: 0000001e37a3e000 CR4: 00000000003506f0
> [75582.362588] Call Trace:
> [75582.362591]  <TASK>
> [75582.362597]  smu_v11_0_disable_thermal_alert+0x17/0x30 [amdgpu]
> [75582.362983]  smu_smc_hw_cleanup+0x79/0x4f0 [amdgpu]
> [75582.363375]  smu_suspend+0x92/0x110 [amdgpu]
> [75582.363762]  ? gfx_v10_0_hw_fini+0xd5/0x150 [amdgpu]
> [75582.364098]  amdgpu_ip_block_suspend+0x27/0x80 [amdgpu]
> [75582.364377]  ? timer_delete_sync+0x10/0x20
> [75582.364384]  amdgpu_device_ip_suspend_phase2+0x190/0x450 [amdgpu]
> [75582.364665]  amdgpu_device_suspend+0x1ae/0x2f0 [amdgpu]
> [75582.364948]  amdgpu_pmops_runtime_suspend+0xf3/0x1f0 [amdgpu]
> [75582.365230]  pci_pm_runtime_suspend+0x6d/0x1f0
> [75582.365237]  ? __pfx_pci_pm_runtime_suspend+0x10/0x10
> [75582.365242]  __rpm_callback+0x4c/0x190
> [75582.365246]  ? srso_return_thunk+0x5/0x5f
> [75582.365252]  ? srso_return_thunk+0x5/0x5f
> [75582.365256]  ? ktime_get_mono_fast_ns+0x43/0xe0
> [75582.365263]  rpm_callback+0x6e/0x80
> [75582.365267]  rpm_suspend+0x124/0x5f0
> [75582.365271]  ? srso_return_thunk+0x5/0x5f
> [75582.365275]  ? __schedule+0x439/0x15e0
> [75582.365281]  ? srso_return_thunk+0x5/0x5f
> [75582.365285]  ? __queue_delayed_work+0xb8/0x180
> [75582.365293]  pm_runtime_work+0xc6/0xe0
> [75582.365297]  process_one_work+0x1a1/0x3f0
> [75582.365303]  worker_thread+0x2ba/0x3d0
> [75582.365309]  kthread+0x107/0x220
> [75582.365313]  ? __pfx_worker_thread+0x10/0x10
> [75582.365318]  ? __pfx_kthread+0x10/0x10
> [75582.365323]  ret_from_fork+0xa2/0x120
> [75582.365328]  ? __pfx_kthread+0x10/0x10
> [75582.365332]  ret_from_fork_asm+0x1a/0x30
> [75582.365343]  </TASK>
> [75582.365345] ---[ end trace 0000000000000000 ]---
> [75582.365350] amdgpu 0000:05:00.0: amdgpu: Fail to disable thermal alert!
> [75582.365379] amdgpu 0000:05:00.0: amdgpu: suspend of IP block <smu> failed -22
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 7 +++++--
>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 7 ++++++-
>   2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 859a17c1f7e4..2aad25dce009 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1669,9 +1669,12 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>   		if (adev->in_suspend && smu_is_dpm_running(smu)) {
>   			dev_info(adev->dev, "dpm has been enabled\n");
>   			ret = smu_system_features_control(smu, true);
> -			if (ret)
> +			if (ret) {
>   				dev_err(adev->dev, "Failed system features control!\n");
> -			return ret;
> +				return ret;
> +			}
> +
> +			return smu_enable_thermal_alert(smu);
>   		}
>   		break;
>   	default:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 78e4186d06cc..b0d6487171d7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1022,7 +1022,12 @@ int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
>   
>   int smu_v11_0_disable_thermal_alert(struct smu_context *smu)
>   {
> -	return amdgpu_irq_put(smu->adev, &smu->irq_source, 0);
> +	int ret = 0;
> +
> +	if (smu->smu_table.thermal_controller_type)
> +		ret = amdgpu_irq_put(smu->adev, &smu->irq_source, 0);
> +
> +	return ret;
>   }
>   
>   static uint16_t convert_to_vddc(uint8_t vid)

