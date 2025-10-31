Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0EBCCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 19:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D90A010E2FF;
	Fri, 31 Oct 2025 19:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q3gmO65u";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1434810E0D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 19:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yo2TEuYtjs7a04syKgIltX5roCtn0YUr1ZVJLAIEITZTDzrPcGyYdOyf9a7V+PpS+gpqdk0d83XhykfVdYv0mNLZv0PlA7L4ObOE4VID8jErrqV8cpan6W8NxUeHHzaT8g3D5O286Zb9oq6jwZULLrV3m+HffNAdH+63Wb/T/027D1Ux0pdNNDlmCk1c8S1phFP6kloZWYdmNpv18ilJlmZtzBbX3wTb2Vbw4201ngUCHon4PdPeGWW2FOd5GHoKUmh1oLzLMVt7AMeb3Oq/zqjHU+FAYXhYXCSlbUbGbliCiNqFfDhgUaNzet5DMSxeq0o9+B+PrMi0m0jkLkycOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6GScsfpYW/6zHZMd3zcCODLzxCzoer7QuPI2Qirhoc=;
 b=JD2a8WGP5+7RBTw+JThAYIVYZI3oYd+7m9q+EFcY1ovvV0zd31dtsPc10f9FLw7FQj4JESQaflApSmnD5tSEv2Vk6VR5UQD/LvnvMLrDPo6G1+xKp1VeEMro+5+ASiQPtk3b28l3nPKBuPBwmuzDOYvCSmM99Gx/aLSrxxJ2e4HWT9xJB1CS2EMiPZSn7Yx/E380xKtk0rOLeYkG6sngatoH9PWI5ToQDqY0AtmH+jXjQ+la1QC9/0u9hDVAdPajfhUuE/WluSFBoZ74Be6PZxKz0BJG5Z3uA/Y6ScL5yWHlthMSHz3CMx9SVwI9J/CGmmFsd1jE1r6RSd9Yfb9GIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6GScsfpYW/6zHZMd3zcCODLzxCzoer7QuPI2Qirhoc=;
 b=Q3gmO65uGJ4TDyA74pYCBQKY7n4uPj0pExhy0RUblXc7dFXNEdQL8/Uo/wThN564FZ1hHheHhRSdgNiQgj0rv/bGS9BeLbgHLQyYLnjKsIUvNCNnAPyGp9iWF4C64UehST1KVtlmiHU857MlTO9Sfb4oFR+4jdlWsHASfysE3bU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY8PR12MB8068.namprd12.prod.outlook.com (2603:10b6:930:75::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 19:15:29 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:15:29 +0000
Message-ID: <69f787a4-1f14-4114-86d2-be6e03fd0061@amd.com>
Date: Fri, 31 Oct 2025 15:15:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Don't stretch non-native images by
 default in eDP
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20251030193943.4064454-1-superm1@kernel.org>
 <CADnq5_N==TV+c99gq+PaxRpi9OVZpcCMZF6ro==JKp0n1zrWhw@mail.gmail.com>
 <ea5478eb-33ba-4354-9ddd-d91b3e896456@kernel.org>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <ea5478eb-33ba-4354-9ddd-d91b3e896456@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::10) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CY8PR12MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 427ccc25-8250-4639-224d-08de18b1daa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QytwZ0JyT2F1WXpiRS9FcmNkbThQVEowMm5xNm92eHF4OWVET01RTk5BK0dQ?=
 =?utf-8?B?dWttRjZBL2ladGhuNFlwcjdoNFBrTUprV2V5RHhPYWNLZElETW5CajNua1Zq?=
 =?utf-8?B?SHlRUGZMWCtRWXp0dnNDd21uYnUrTlFLRXYvbVdHZW1peDEzelFzSVd5S2Yv?=
 =?utf-8?B?U1F1eUFTRGM5ck1mRk9WT2xKUDMvUDZ1KzNHYlFqZW53WG5DUldlYU1BYWlw?=
 =?utf-8?B?MFRXUDI5cEc5U1JQMDVWaXZ6S3NZc3g2NGxNTGxSNUMvcklrVzRuVVo2OGti?=
 =?utf-8?B?TUMvT2hITENNU2tES1FGdnFyMG9mbmhHUEZRS0E1dkhyUHFZaUpHQ3BjZkxz?=
 =?utf-8?B?cWhpbHQvT1BnQmpPMEZlcTkzcjdHVWkvVEl4N0hMMlFHam0rWnNsNTJ6WkdU?=
 =?utf-8?B?YXVMWHZBeFBDNGRaM3dkWkFqSnp2by9Ubkw0N3dEMXFXNTlCcHBaSGR2eitx?=
 =?utf-8?B?Z0lWYVV3SVBUakt2bkxpVUZ5b0NCM1dtbitCQk41OHU1dG5KTkw0V2JlaVhi?=
 =?utf-8?B?djJtWHhMdzBSU0U4MVZ1K2tnWGU2RjNFVW9Tb0lkelVwalhyQmpzVkZ5ZTlI?=
 =?utf-8?B?dlFVMmZkeW1henZqRGxqRmErRzI4M3BOQ2dPVklGWWQ1RVZoRXNwdjBwNi9I?=
 =?utf-8?B?eHd2bWxlR0ZtVm16eUxkdlA3dUdtU05TcnZsYWN5cG9qNjdVMDRIeTlhSmZG?=
 =?utf-8?B?Z1pOMnprS2Y2c2hiS1c3VkdPVTlOZXRORkhRdHVoc2Q5WXNRcXFyUTV5bVdr?=
 =?utf-8?B?ZFMyWjdKUk5JUGJMS1hPa2QxY25DWllobTc0L0djbHEwK0UvbFJILzlnSGg2?=
 =?utf-8?B?WjlqdU5mSDd0TWRYWExUWmdWdjliR2dUZWo2TGxRdElmM2oyOGlPWEE2Uk00?=
 =?utf-8?B?eFRPdE1jMTgwT0FpQVpBRVpGb3RxaHN6Z0kyUkpQQkNOMmJaMjVQRWhrdGxE?=
 =?utf-8?B?K2c2eitwRUZxTy83VlJ2SFdQRDNpSDAxK1FELytBbDJMa2NZa1VxNFRmeFZQ?=
 =?utf-8?B?dGpjSmRSdEZYVTIxZ1lTSkxVUWdxSCtKUEhzU2hMVUJkQXhreDNEWnFIczdn?=
 =?utf-8?B?Vit2dmJDNUh6czB4TFdCeGRDZmtZNlNuL3o2R0dYM2x2R3dqS3E0L01qcEto?=
 =?utf-8?B?Qk5rSSt0YVQyUW9oejVySm0wRmVENURpcGpidmJYREZOYnVXazduU3p2aWx3?=
 =?utf-8?B?SmM3Z1pNQ1VoZzl3UnR6T0ZWQmhBOWd1Mml3em51cHZuVzRBdTR0N04zbFgv?=
 =?utf-8?B?Q1NRby9QbGtvU2NwS1o3NlFpRUV3TmFHVzNkeVBBQ2ZQV01IbkJPRWEyeEJx?=
 =?utf-8?B?Uk5zeENuN1I0a3pDK0FGbVdoeFQ5MjhVaW1wM1hEanpSSDJHTGw5OHk5WWFp?=
 =?utf-8?B?Y0oyN2t4T3lJUjJmQ1RmZFNXd1V5cDlpbDFVKzY1U0FNTGJYeEVHQmFkNDY4?=
 =?utf-8?B?N1d6bTlvdndUaW5FQ1FRWkJ2TitmcXJEcTM1WnJZL3BUNlFqckYvUjBRRnZP?=
 =?utf-8?B?R3huVTVhT3pHV05mTDlUVDU5OXlLK0FJdG0xZG9adFJMUUVWK3d1azBaZFU5?=
 =?utf-8?B?Q0VTRlBmVlcvVUlmTmNGUGR0ZnNXZkdaaFh5VkZ2NEE2eG51UHRJZnI3VHhT?=
 =?utf-8?B?eEpmWkF3aVJnS0NZMVBXYjBYK3ByNTVLWFo4QlFXdE80NmJlMDBleXFoblV6?=
 =?utf-8?B?TUErNjVIN2dlcGhSZWRVRWl5RVhTWTRRU1VZc1Nxd1ptb0V3MEwxSkxEVzl3?=
 =?utf-8?B?OEwyK1lqQUJTaDhoMmhxVnR1QVVZY1pCVUhXbml2dTJ6OEV1U0NySW1vRTd2?=
 =?utf-8?B?Y1EzdDV5OWpzcVMxZGY0Ykl6ajV1UVhrR0d3NnpzbDYxaEtyeW9LbXkreWpr?=
 =?utf-8?B?VWpGSHFhUktvVTduN1F3bFdEWDQ2K0pnSWJyN25xRmNOK1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3FIYUc0L25HSENkOExUNFF2TytPd3BtczBXMWVJbE5lSGRCeWxJdDVHTExh?=
 =?utf-8?B?OGt2ZmxJTlpCQzhwRWdSdG1ROVIxakRBdVEyUERicHlrdkpMclZlSE9lZ0tB?=
 =?utf-8?B?RUhEeURaUDJ5UkJsMUNpcTU0cWNQbVExaGhPWGlZQkZFZ01tUzdyaHNuRjc0?=
 =?utf-8?B?UENva1UyR21BeWgvamoyc1gwUytxeDIwWjV3Tzh5WXgxK2JZY01HSGtiTWo3?=
 =?utf-8?B?UW5xcmFXRjNFcE95UFZuMEt1d0tyM2hEbWFIT0x6SjZ5K2grRUJSdGZMSC9I?=
 =?utf-8?B?MDhGbURFV0ZhQVBZbXpkRHlyYlJqdlFXeld6TXFOVnVMQUFid2hjMm1pL1JZ?=
 =?utf-8?B?dndiKzFwbWNPTHQzeVZOUG80UjhVVUg3YjFuL3lXbllWOXFiK01Rbmd5Z3cz?=
 =?utf-8?B?REFwSXVwSjNCRk53SnduMStSNU1MSUZpZ0Q2dlRXKzZVMXo2OGdETlBrWENB?=
 =?utf-8?B?L0d3Z3F6ZFMrOHNBYkdqanVqSmZ6L0xla0w3ZCtNNWo1VzhvRkxncTU1ajhI?=
 =?utf-8?B?TnQ3VFpaNnJYZU9EcFdXNFB2VGhxU1VZdmZwNXVXbzd6aW1aNnFtSmRJQWVD?=
 =?utf-8?B?OUgxUU5yUnVMMFZOaEs2YVZxOGVLZXRTUVc3Z2VGSFpSbnRwazlRNGREdHRy?=
 =?utf-8?B?UGtiZFNiaGxiR3ErOG80K0VZVlIwV215T1Q1TEdrdjFoQnc3S0QyUTFJcTVC?=
 =?utf-8?B?eVpIYUdqU1dxSk1DRjJxOTF0VXN0R2hJUmJ6dndkdXdtc0ZqVERPTlhtaE1x?=
 =?utf-8?B?bU9GdUhsa2J6VXBESUhjcGtIci80ZXBaQWxyRjdGYmdRSW4zM2dDdFRnY1JS?=
 =?utf-8?B?cFZKeldyTktVbEhldmFSU2FJNWpWRTB1WnloT256MEw0UXIrMjUrTnJ6anF5?=
 =?utf-8?B?SVROcHUwb09CYU9QZVlSY0hsNjVBbE1BOWp3UjhXbjJWOTdIWVBjc3dVNkJQ?=
 =?utf-8?B?QnZycGU2SThVM3ZBUklJM3RCSkc3TlowSEdlaVBjeHp0amVSbjR4cTl5Y01m?=
 =?utf-8?B?aEFsSUZLVFVCMFFoRjdab1RqTzc5cGx5eW1aZldtMkVyUUhTMlBZWkt6L05X?=
 =?utf-8?B?ZEtMTEU5U3hhbXJ0Z0phVTNBOEx1STBKMGh3N3UyL0drWlc2VnQ5L05NVlQ2?=
 =?utf-8?B?aEVubkZlM2xtYzkzNklVZjZ5WHJuUkhrTGgzZWNXeHF1bTNaKysvODBUTUtv?=
 =?utf-8?B?TnF4cExoK2JCVGJ4Y25ONDlad29SRzcrTFQzL1JCeUpZajFwOFh4elRBcGxt?=
 =?utf-8?B?WnRNZmpZSlE4R0l3QVRtY1dxOW4wOTRhazhCQzdvb2JENHhEYmlVUzR0K0Ju?=
 =?utf-8?B?RytkWEFISDgwc0hTWTVHci9aYmZZRFE0TGlQeG1RcFFZYTZpa1ZnTWJhRE1S?=
 =?utf-8?B?RExGS2c1amZBQ2RPRkc2UU8wOHNvcHdET01KNXZFNU5ZN3R3ZmpSMnhIL3lS?=
 =?utf-8?B?bHhsS1c0b1FIYzhQM1A4L3BTY1dHYXVya2VIblpLR0FLUk1VdDF0cDR1OFV1?=
 =?utf-8?B?ZHRKRlJNUGFZazRETkt6VE5vSXRLUndXRko4SGQyenlFdGpqOHJ2Nzk0V1Bv?=
 =?utf-8?B?d1A5TE1NbmFyNU1pV0x4UEdVNC9FcGRsei9seHVwM2ZIZ05tQTIvS0YrTEw3?=
 =?utf-8?B?bHZFV2JtL0RtUEx1S0hoVHdWSVNCL0dOZ2xJVWYzRTl5aEd1UktKSnlEV2Nl?=
 =?utf-8?B?WW1NQjY1MzV2RVJxSDFqVEdnb3cxeURqQWhaNldNZGRtSzJsdVZ0Yy9SR3Ex?=
 =?utf-8?B?Qy93YmpLazdPY2srdCtPSHBDSU91ZWgxNmFnY0cwWSt1emJnMzlzWXhoVWFJ?=
 =?utf-8?B?V2RxeGtBcVBnZ0ZjM1o5clVqM2t5elZQTmo1TitjWlNlK3BJQm5xOHFDWjZk?=
 =?utf-8?B?aUxyY3hKWHozY01RUUZaR2FhUGxuRy9uakorbzl0VmhzRTBzdjRmTlpNNFBK?=
 =?utf-8?B?NjZkYjROZXdFNVJMWkpBNGZTYzYyT0tvUTVqNlBDdTJtdlY2ZzNSQW9jaU9p?=
 =?utf-8?B?WHFzT1FsVFQ2YVNReXpwY000eW03ZUZZdG1kUDZnTnc0eU1URVpWUzJMejdj?=
 =?utf-8?B?WW1hMkVDbndtR1hDNUFVZGdSU0ViaU4wUklPVkVNSzZLeTNBcnRVM0FUazln?=
 =?utf-8?Q?qJe7rGYhy/nqZcf3viY51K0gQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427ccc25-8250-4639-224d-08de18b1daa2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:15:29.1084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtbFfNprBiBNJGer4pmhWrgbP3JowXegSjmKLOFvGHTe1ujVb1ITdFFSo6Pwxc8LRtAASsyfDl05zhIwBpT4tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8068
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



On 2025-10-30 16:50, Mario Limonciello (AMD) (kernel.org) wrote:
> 
> 
> On 10/30/2025 3:49 PM, Alex Deucher wrote:
>> On Thu, Oct 30, 2025 at 4:16 PM Mario Limonciello (AMD)
>> <superm1@kernel.org> wrote:
>>>
>>> commit 978fa2f6d0b12 ("drm/amd/display: Use scaling for non-native
>>> resolutions on eDP") started using the GPU scaler hardware to scale
>>> when a non-native resolution was picked on eDP. This scaling was done
>>> to fill the screen instead of maintain aspect ratio.
>>>
>>> The idea was supposed to be that if a different scaling behavior is
>>> preferred then the compositor would request it.  The not following
>>> aspect ratio behavior however isn't desirable, so adjust it to follow
>>> aspect ratio and still try to fill screen.
>>>
>>> Note: This will lead to black bars in some cases for non-native
>>> resolutions. Compositors can request the previous behavior if desired.
>>>
>>
>> We may end up getting bug reports about the black bars.  We had a
>> similar debate about what the right default was for radeon 15 years
>> ago.  That said, at least with this the pixels will be square with
>> this patch.
>>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Thanks.  Yeah that was my thought too.

I think not preserving aspect ratio is rarely ever the right
call, especially since all modern displays have square pixels.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> 
>>
>>> Fixes: 978fa2f6d0b12 ("drm/amd/display: Use scaling for non-native resolutions on eDP")
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4538
>>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>> ---
>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 29b9197bbbc32..5b279182e66a8 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -8078,7 +8078,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
>>>                                         "mode %dx%d@%dHz is not native, enabling scaling\n",
>>>                                         adjusted_mode->hdisplay, adjusted_mode->vdisplay,
>>>                                         drm_mode_vrefresh(adjusted_mode));
>>> -                       dm_new_connector_state->scaling = RMX_FULL;
>>> +                       dm_new_connector_state->scaling = RMX_ASPECT;
>>>                  }
>>>                  return 0;
>>>          }
>>> -- 
>>> 2.43.0
>>>
> 

