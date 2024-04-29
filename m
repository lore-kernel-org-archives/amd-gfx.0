Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817BAC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 07:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0372410EDD7;
	Mon, 29 Apr 2024 07:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OGycAjO3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77D6710EDD7
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 07:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBlptuZkmL/gaONoqJD0h524vVo0geGuZ/2hYVWjRtx4zplJ9S2yaw0mI+WuuHAfpseeQR3VsOv6Loea6gcVw/l3kd3gVDcF63FrBvAh+1+8dyequdM8D86AgSdXQFEUEvILPkXFFVuMl4PsCKs6ba2ZywvDuHZbvX6aFLk1oQbeIHTNkae3sX+VYE7pli8Sf7hdk0CXuyfZKhFgg8iZoL4QsO7Q8hbl9h/iLE3jcvbrs1XD6GHPU5uE+Sr6iSYXsv/u4BuhZ/a7NYjZspqUEaUr8qrol1c2Ap4NJk356jO4/nOO1atckdYjP9ADHahXNtre+W6kwI2Nd4VV5Lm5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUuLttiRQ+iqSB0hWMXIdGBf+UPhrzXODze2Gt1Nm1s=;
 b=SwJ5KHgpYQbLPZtBKha+t7dCDl/iGnbCrak7UWx2nq7Ch7DVlkOAdieHYZUSQit0PwZCU4ATuOHxgm+wcCmlTOrsB2n5/caFhQPjG+0QciIYiZL83MuqsIPw/+p37OiNXbMN+eIeOfuQi3Ti+5fILo4kYCqEdrv8RRRSSp8r+xLhQl6YVHDoTc+TS3bW3dovz9KoxvyJdS9azdlUy0K4m6kbf3qIUlZe6ymf6bKh5MxHfmT5kKQMd90Z00+Vf4rJQykBIWIEhGoZd4+xLlpRspINrGj1558yYcJlvKH9/VVh2CqytvtE37Y0xnoOHSB78sK/2aSZbHsi4FcUa6sWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUuLttiRQ+iqSB0hWMXIdGBf+UPhrzXODze2Gt1Nm1s=;
 b=OGycAjO3fISULcC+nYYBzynGGpA3lh5f0/h37pllz926+A2CiMGKy2XNsYgBlAbDH4G5nea/xAEXVwTQ4g1xHmZgzS4I+owQCC9hhLNnYZioET1NZTa8T8to2lYyt081NOfAPHYLPhPhc2W+TJBElC3dYtyRViVU8jaNft7t/Rg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 07:44:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 07:44:11 +0000
Content-Type: multipart/alternative;
 boundary="------------FCGVtaxqKkqMkNURYCxGLqx9"
Message-ID: <a9e1cefe-90b0-4be3-b143-1d587a550412@amd.com>
Date: Mon, 29 Apr 2024 09:44:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Reporting a slab-use-after-free in amdgpu
To: Joonkyo Jung <joonkyoj@yonsei.ac.kr>, vitaly prosyak <vprosyak@amd.com>
Cc: Dokyung Song <dokyungs@yonsei.ac.kr>, Xinhui.Pan@amd.com,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 jisoo.jang@yonsei.ac.kr, "yw9865@gmail.com" <yw9865@gmail.com>
References: <CAKc8oVUXUHUYQSDYDZ3XqpfwcmOwoxii5+SkyteXoZSPRwshfQ@mail.gmail.com>
 <CAKc8oVU8C-MRVa640603R2Gi7BRZ5P8ZN_uJoruDzR_A8xg71Q@mail.gmail.com>
 <f3cb1403-6822-44b2-95fe-ab5f50ca3736@amd.com>
 <CAKc8oVXw0YhLdBHZUcc73aFAeL-zioCpEsNZYW7c7y70DYds-w@mail.gmail.com>
 <CAKc8oVXPpfOfCnF+72c2Sr1joimMqXENxsFtKiRi==mb-Fg0HA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAKc8oVXPpfOfCnF+72c2Sr1joimMqXENxsFtKiRi==mb-Fg0HA@mail.gmail.com>
X-ClientProxiedBy: VE1PR03CA0023.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: de3d112e-b651-4ac1-95c4-08dc68202874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXR5VXgrRVNKSnN4OHJUUFBMTmcvZ3dhVFArUzJOaERyNUl4eHVEQkJYblF1?=
 =?utf-8?B?cm5GdGFrOUlBdU9GcmRtbDNFOURWU1gwcUpQaEJ6dEd0K05lQnR4bDVmazhk?=
 =?utf-8?B?REtLYUZzLzBYK0RXUFBaMnVQb25yV3VmUERZUTB4UEdJNFV0cXgxbnIxNlI0?=
 =?utf-8?B?dk56R01oYm9yeUZCb2N6aXdheWNvcjZRY2ZVTzI1bzltL280OXNDN3dMbTBq?=
 =?utf-8?B?VmI0Z0JTVlE3dHFBSkVWZUdiKzJ2Tks1Nk40YmI3dnZocnpiSWQ0YVRJUDZq?=
 =?utf-8?B?YUFsbXk0Ri9CQjVsYXljT3cyYUl1QUVZZ2E5YWpUQ2dVeW42ZkJySFlQNUpr?=
 =?utf-8?B?Umh3YXJkU2NuK3RvZ0FvdWs4cE5FRlBwT2lHWGFmazFpcmtNbmR1UjdtMEhu?=
 =?utf-8?B?MkVNMXVzL2lNT294L2kxc3BvL3dwdFRhRHBPWEVZbzBhVU1DNVBjK3A3RHpk?=
 =?utf-8?B?UmJaekx4ck9OeWdINUpNMWQxZzc5NGxVY0J5UlAybmQxZ3RERjFMTFh4bitR?=
 =?utf-8?B?L0xiMGNySGExMmJydzBqT2g1QzhiNW9FL0xVQTI0eloyb2Y0emFZMGt3NmY0?=
 =?utf-8?B?ZEFYQVh3YUJwb3kvYWI0SkRMYjhPK3lpN2FLSzIyaVY2cHlnd256WTNvNlY3?=
 =?utf-8?B?bzJhUGZFMzdML0FOSDF0bDZnSENMRmpXNWFCbTUwbnVaMEptSHV4OXdiTzI3?=
 =?utf-8?B?dGFPa0M5eUlPTFRuTWpHdGpZekxQc29abTFOZW9DVlNyWVhwdklUd3ZsWmdk?=
 =?utf-8?B?OE9vUWh0bHNBSEkzSDQ4a3F4S1VVWHZVUmh0QU4wdXNGL2k0ZWlkVGt3amlW?=
 =?utf-8?B?ZzV1RWZKNm5JWE5KbUJNWmdCTENoRzlPNm5CKzVxUEgyelIzOGJMSFg0M1RS?=
 =?utf-8?B?dVJrU2UrV0hlM0tPVngyQWJsUTF0bGk2WEJ2QUdVZFN3ejBpWTVKbUVSZ0xJ?=
 =?utf-8?B?aDVpaXpNUkNqajIweGlTbXJ0YmhGeXVoNVI3RzlYZ29aM3g3UFhrbFAxMHVw?=
 =?utf-8?B?STFPaVppZjlKVFhWckJKYzR3eEtTRFE5UVh4eXdSNGNSdkl6MTNybWhtd2Na?=
 =?utf-8?B?VGpQT21qNU5lNFJRZ0o1K0cwcXBvZk55aVFPNUtwVFBWVUl0M2dkTjYxMHRj?=
 =?utf-8?B?L2crc3BGZ2oraCs4TlF4K1R0UGVuQ2p2TllHRHRkQ2kzTXlRSVdSY3dEdmVa?=
 =?utf-8?B?aGtSV2E0MlRnSkdEaHk4V2RtQXdFNllxWVRJeTFiQUhoLzdidU9VWFlvNzcy?=
 =?utf-8?B?M3FRL1dvdG0ycUljUGgyQmE3L3NYZnBjc0JoSFpDbWo1NW5ybmpsdGNhenZ4?=
 =?utf-8?B?U05SNGNCZlZRN0RLY1dmdTIzOXBaOFlOL3E5M1JvSW50RHZyaUthTFVuQ0hp?=
 =?utf-8?B?ZmltV0lRV25uQ0ZVZ2VYUWU2WkpCeHJJVzgxak95WFFuQnZuczMrQzhaa1NV?=
 =?utf-8?B?a2JKVXNUbjNEam5NRkUyNkRNZVNFdUpFWVJjVjd4cG9FMjVVckxBS05Qd2dK?=
 =?utf-8?B?UCtncXhmeks4R0E0UEV4eXVDQmNrRWFFM1JTeURNTFRZeGxFMkc1UG5MOFYr?=
 =?utf-8?B?UjFFZTEyMnhaT0JhWEZJOGFMRVBBMWlNN1VydjA0c1hVRi9aNFlqMmYyRTZ2?=
 =?utf-8?Q?kxQmUwwdM2YjzLi4nCCY9RRrKTCOgPsmt5wcJveXvrQU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWk0OXB0dzk3M1JuTCt1cUR3V3pHS2JWRTRoTHdUVlZ6bThoNEVkSFlyRWYw?=
 =?utf-8?B?R0Jyd0FWRjhCQUdtWERTcU45UEFsS0VycTZZNmYxVzEyMWpsZEFybHA5dkVO?=
 =?utf-8?B?MEg1R21ZRUE0QVNUaktjQVdCMlo2RFZQVjh1Smx4SlZFUkdvdmVaV2VZaXk0?=
 =?utf-8?B?UUM1cm5hc1RCOXg4eGEwdzA2TDE4bVR1bFBQSjdITjU1Sk5OWVhYRjJ6MFR3?=
 =?utf-8?B?YWlhd2taUGJtN21sY0VkTDl5VHNoeDloSlh6OXV6NUdYcG8xVFY2SXhTTDFy?=
 =?utf-8?B?L0x5OVF2QWZDdm5BY0hNOFltVGwvNHA2d0ZDVFlQNHlpamoxT0xOU0dSV3Uy?=
 =?utf-8?B?a29EUmJZci9DMEE0K3RkVnlkS1Z5QlFVdmJwZmRtd2dmdWJCZjhWRFFEZ2pG?=
 =?utf-8?B?dWNBbjU3emRDNlc0Slp2Z2RuSXB6elNhREpqMlpuRmVrdlJrdmhWUjRNN0dP?=
 =?utf-8?B?Y2s3cHhFWWNQSER0S1BKQVhYSGhNbk9jaTFnTXNOajZqZ0FTSGpIZGZFc1RX?=
 =?utf-8?B?K1BmOThCcFVVcjRWazh4ckJ3VlNpZzhxblZmbnFwRHBtbUJLemtuMkNIM0dq?=
 =?utf-8?B?Q0RQZWo0bXdSRXBBZWh4cDhBQit0WXRYYk5sRlMydEFUMVNHQ2tCM0N5SkJB?=
 =?utf-8?B?bTBTalVURERMZ1Q2TmZyaGtWaGFzQVJKTWVBZ0JqZ2V4Tm80YWt4NCtoaG1U?=
 =?utf-8?B?bFFCTU9RNk1PNW1SREFEcHBPMEltbTVTZ1MvSjF0Tk5rdlptQTVMOXkzVlM5?=
 =?utf-8?B?bVpBbmhnUnpxYzlRZUVYb21zZk1RcVJUaE53NlQ3WE92Rnk5dDNkVEpabHJv?=
 =?utf-8?B?TW9yY2dUZmNudVhERmJUWTRwK0RaSHYxaVJBeTdHNjdYSVRZYmRTMmU1T2Fi?=
 =?utf-8?B?ZW1HSjRnRDR5KzB6Zjg1K2o1N1dqQVJMenAvWGpuVTBIYjVrTUxrdy9FbVhk?=
 =?utf-8?B?aHAvMm9oMUNXV0tQSmlocEppclZKck9ZL0pJOVlQeVBKdUVwYkdVOFJSa3NW?=
 =?utf-8?B?K1QxeTMvVXUwS1JxS1oxbC9idVkvV1V6ZkNhVTZaUGwyelpKcFVQTDJEb3hX?=
 =?utf-8?B?V0duZWJVOHVaa25rVW02bGdnejY1K2hnVEV3S2x4VVQ5aXRMK0ZMa2ZtM0xo?=
 =?utf-8?B?aFlBNUlneEZsWVQzY0VJeTJ5WnVXeHhjNXI3aTB2ZnMyb2d2TWQrZ1grZVNj?=
 =?utf-8?B?cEtpNXdLekJnM0xLdmxCa25BSHRqdHhwS2ZvanZRYit1ZTdTeStoOUI0SUxj?=
 =?utf-8?B?b2dZQTBoUUpqRWhkM3kydW5tWnRBb3I1Z1pXeGd2VVBRYW04V0xTMjlmbHpz?=
 =?utf-8?B?T3BFcDQ5TmZ2eUJGSEdqdjBDQ1lqNjdhU2xmSUxoV3YvRC9sY2M0aS9rZzZy?=
 =?utf-8?B?cXFJRjJ6TVJWSkVTWDQ2b25XOTJlbjZHVS9TOFVKay82bVJQSHIzczFFNXU2?=
 =?utf-8?B?MmEweGtPcnRmRUs5OFJyRHBmRlkyRElKczZLWFk0U1BUNXRrOWtVcGpDVDA0?=
 =?utf-8?B?a2hqVVptOFlDcXRpekRZcVgwVjYwdVF0dEpjQjhrcER5WlRIZzNtcXVJUnlr?=
 =?utf-8?B?MnBNZUplQzVueURpRVpOb3A0aHlmend5cWJRWnJHN3BXbDBsQ2NyVG9XcURz?=
 =?utf-8?B?S2FiZ04rV2dpbndKQ0FvVHE4RFphdjNsandySjVyUFVDc3hFdEU3S2p0VS9r?=
 =?utf-8?B?K2lidVozeTU4cHI1N21zQjBld3cycnpwdXlWVHhwWW5nc3ZycEZ5RDZmbzZL?=
 =?utf-8?B?U2VwemtCeUNhTzRYOUNFbXBIYzRsREJ5aExhUUpMOXB4VnpsemtaNUhidlhq?=
 =?utf-8?B?YTZuSHhKVzBvMnVub3RxcmtlK2hTYzVMcFpIVXp0WG9RMjZNVnBhdy9XUkFP?=
 =?utf-8?B?a1ZsckJaSjBnUmV0VVRCbU1rVUZSam8xVEMwN3FmOXUzYXRMb2pCeC9Rc2RF?=
 =?utf-8?B?WDU0NjA5cElKMytZZDF4SGo2UjhOdUFFYWx4KzZPVjJ4cDMxZTFPaDJzaUtq?=
 =?utf-8?B?VFNaWFRqVm5LSkNGb1FOVUQ0bVVPTGFtKzBoSENFZnE5WnZxTDdFVlRKZU5X?=
 =?utf-8?B?NVJ0Yml1cnNNOXpZeloxVHpOR3pYVVRWdnpNOTh4MUlJT1lOZld5TFBNeTdV?=
 =?utf-8?Q?33zc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3d112e-b651-4ac1-95c4-08dc68202874
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 07:44:10.9726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8OxC+R96TXyQzwW1sRSPqqaoU4sb8kpBPCDHx8wCqWl9MVzlfERMmbiWQ0+GvfW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
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

--------------FCGVtaxqKkqMkNURYCxGLqx9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi guys,

yeah that is a well known issue but actually completely harmless.

What happens is that a trace function accesses a stale pointer to print 
some additional value into the trace log.

That memory might have been reused and the information is now outdated, 
but the worst thing that can happen is that the value in the logs is 
nonsense.

I have a patch in the queue to fix this, should be upstream and 
backported in the next few weeks.

Regards,
Christian.

Am 29.04.24 um 04:15 schrieb Joonkyo Jung:
> Hi,
>
> Thank you for patching two of the bugs we have reported!
> I was just wondering if there's any news on the one other bug we have 
> reported:
> BUG: KASAN: slab-use-after-free in amdgpu_bo_move+0x1479/0x1550.
>
> I see that there is a gitlab 
> issue(https://gitlab.freedesktop.org/drm/amd/-/issues/3171) created 
> for this bug,
> and there also is a 
> patch(https://lists.freedesktop.org/archives/amd-gfx/2024-March/105680.html) 
> that Christian made for this.
> Though, it seems that the issue is not resolved yet, and the patch is 
> not yet pushed to mainstream branches.
> So I was wondering, do you have any plans for pushing this patch? If 
> so, would it be possible for us to get a Reported-by tag on the patch?
>
> Best,
> Joonkyo
>
> On Fri, Mar 8, 2024 at 4:32 PM Joonkyo Jung <joonkyoj@yonsei.ac.kr> wrote:
>
>     Hi Vitaly,
>
>     No worries, thank you for working on the patches!
>
>     I have also confirmed that with the inflight patch, issue No.1
>     (use-after-free) seems to be resolved.
>     However, I have reproduced issue No.3 (slab-use-after-free) even
>     with the patch for issue No.1 applied - if it's the first program
>     tested after reboot.
>     (i.e., if any other bugs are tested before the
>     slab-use-after-free, it does not reproduce).
>
>     Could you check if the bug reproduces in this condition for you too?
>     I will check and see why this is happening and update you if I
>     have something new.
>
>     Thank you!
>
>     Best,
>     Joonkyo
>
>
>
>     On Fri, Mar 8, 2024 at 12:45 PM vitaly prosyak <vprosyak@amd.com>
>     wrote:
>
>         Hi Joonkyo,
>         Sorry for the delay.
>         Yes, sure, I reproduced issue 2 (null-ptr-deref in amdgpu) and
>         I will provide the fix soon.
>         However, issue No. 3 is no longer reproducible if the recent
>         patch inflight is applied which fixes issue No 1.
>
>         Do you see the same behavior?
>
>         Thanks in advance, Vitaly
>
>         On 2024-03-07 20:18, Joonkyo Jung wrote:
>>         Hello,
>>         thank you for patching the first bug we have sent!
>>
>>         Just a quick touch base with you, to ask if there has been
>>         any update on our other two bugs.
>>         They were each sent with emails titled
>>         "Reporting a slab-use-after-free in amdgpu" (this one)
>>         "Reporting a null-ptr-deref in amdgpu".
>>
>>         Thank you!
>>
>>         Best,
>>         Joonkyo
>>
>>
>>         2024년 2월 16일 (금) 오후 6:22, Joonkyo Jung
>>         <joonkyoj@yonsei.ac.kr>님이 작성:
>>
>>             Hello,
>>
>>             We would like to report a slab-use-after-free bug in the
>>             AMDGPU DRM driver in the linux kernel v6.8-rc4 that we
>>             found with our customized Syzkaller.
>>             The bug can be triggered by sending two ioctls to the
>>             AMDGPU DRM driver in succession.
>>
>>             In amdgpu_bo_move, struct ttm_resource *old_mem =
>>             bo->resource is assigned.
>>             As you can see on the alloc & free stack calls, on the
>>             same function amdgpu_bo_move,
>>             amdgpu_move_blit in the end frees bo->resource at
>>             ttm_bo_move_accel_cleanup with ttm_bo_wait_free_node(bo,
>>             man->use_tt).
>>             But amdgpu_bo_move continues after that, reaching
>>             trace_amdgpu_bo_move(abo, new_mem->mem_type,
>>             old_mem->mem_type) at the end, causing the use-after-free
>>             bug.
>>
>>             Steps to reproduce are as below.
>>             union drm_amdgpu_gem_create *arg1;
>>
>>             arg1 = malloc(sizeof(union drm_amdgpu_gem_create));
>>             arg1->in.bo_size = 0x8;
>>             arg1->in.alignment = 0x0;
>>             arg1->in.domains = 0x4;
>>             arg1->in.domain_flags = 0x9;
>>             ioctl(fd, 0xc0206440, arg1);
>>
>>             arg1->in.bo_size = 0x7fffffff;
>>             arg1->in.alignment = 0x0;
>>             arg1->in.domains = 0x4;
>>             arg1->in.domain_flags = 0x9;
>>             ioctl(fd, 0xc0206440, arg1);
>>
>>             The KASAN report is as follows:
>>             ==================================================================
>>             BUG: KASAN: slab-use-after-free in
>>             amdgpu_bo_move+0x1479/0x1550
>>             Read of size 4 at addr ffff88800f5bee80 by task
>>             syz-executor/219
>>             Call Trace:
>>              <TASK>
>>              amdgpu_bo_move+0x1479/0x1550
>>              ttm_bo_handle_move_mem+0x4d0/0x700
>>              ttm_mem_evict_first+0x945/0x1230
>>              ttm_bo_mem_space+0x6c7/0x940
>>              ttm_bo_validate+0x286/0x650
>>              ttm_bo_init_reserved+0x34c/0x490
>>              amdgpu_bo_create+0x94b/0x1610
>>              amdgpu_bo_create_user+0xa3/0x130
>>              amdgpu_gem_create_ioctl+0x4bc/0xc10
>>              drm_ioctl_kernel+0x300/0x410
>>              drm_ioctl+0x648/0xb30
>>              amdgpu_drm_ioctl+0xc8/0x160
>>              </TASK>
>>
>>             Allocated by task 219:
>>              kmalloc_trace+0x211/0x390
>>              amdgpu_vram_mgr_new+0x1d6/0xbe0
>>              ttm_resource_alloc+0xfd/0x1e0
>>              ttm_bo_mem_space+0x255/0x940
>>              ttm_bo_validate+0x286/0x650
>>              ttm_bo_init_reserved+0x34c/0x490
>>              amdgpu_bo_create+0x94b/0x1610
>>              amdgpu_bo_create_user+0xa3/0x130
>>              amdgpu_gem_create_ioctl+0x4bc/0xc10
>>              drm_ioctl_kernel+0x300/0x410
>>              drm_ioctl+0x648/0xb30
>>              amdgpu_drm_ioctl+0xc8/0x160
>>
>>             Freed by task 219:
>>              kfree+0x111/0x2d0
>>              ttm_resource_free+0x17e/0x1e0
>>              ttm_bo_move_accel_cleanup+0x77e/0x9b0
>>              amdgpu_move_blit+0x3db/0x670
>>              amdgpu_bo_move+0xfa2/0x1550
>>              ttm_bo_handle_move_mem+0x4d0/0x700
>>              ttm_mem_evict_first+0x945/0x1230
>>              ttm_bo_mem_space+0x6c7/0x940
>>              ttm_bo_validate+0x286/0x650
>>              ttm_bo_init_reserved+0x34c/0x490
>>              amdgpu_bo_create+0x94b/0x1610
>>              amdgpu_bo_create_user+0xa3/0x130
>>              amdgpu_gem_create_ioctl+0x4bc/0xc10
>>              drm_ioctl_kernel+0x300/0x410
>>              drm_ioctl+0x648/0xb30
>>              amdgpu_drm_ioctl+0xc8/0x160
>>
>>             The buggy address belongs to the object at ffff88800f5bee70
>>              which belongs to the cache kmalloc-96 of size 96
>>             The buggy address is located 16 bytes inside of
>>              freed 96-byte region [ffff88800f5bee70, ffff88800f5beed0)
>>
>>             Should you need any more information, please do not
>>             hesitate to contact us.
>>
>>             Best regards,
>>             Joonkyo Jung
>>

--------------FCGVtaxqKkqMkNURYCxGLqx9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi guys,<br>
    <br>
    yeah that is a well known issue but actually completely harmless.<br>
    <br>
    What happens is that a trace function accesses a stale pointer to
    print some additional value into the trace log.<br>
    <br>
    That memory might have been reused and the information is now
    outdated, but the worst thing that can happen is that the value in
    the logs is nonsense.<br>
    <br>
    I have a patch in the queue to fix this, should be upstream and
    backported in the next few weeks.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 29.04.24 um 04:15 schrieb Joonkyo
      Jung:<br>
    </div>
    <blockquote type="cite" cite="mid:CAKc8oVXPpfOfCnF+72c2Sr1joimMqXENxsFtKiRi==mb-Fg0HA@mail.gmail.com">
      
      <div dir="ltr">Hi,<br>
        <br>
        Thank you for patching two of the bugs we have reported!<br>
        I was just wondering if there's any news on the one other bug we
        have reported:<br>
        BUG: KASAN: slab-use-after-free in amdgpu_bo_move+0x1479/0x1550.<br>
        <br>
        I see that there is a gitlab issue(<a href="https://gitlab.freedesktop.org/drm/amd/-/issues/3171" moz-do-not-send="true" class="moz-txt-link-freetext">https://gitlab.freedesktop.org/drm/amd/-/issues/3171</a>)
        created for this bug,<br>
        and there also is a patch(<a href="https://lists.freedesktop.org/archives/amd-gfx/2024-March/105680.html" moz-do-not-send="true" class="moz-txt-link-freetext">https://lists.freedesktop.org/archives/amd-gfx/2024-March/105680.html</a>)
        that Christian made for this.<br>
        Though, it seems that the issue is not resolved yet, and the
        patch is not yet pushed to mainstream branches.<br>
        So I was wondering, do you have any plans for pushing this
        patch? If so, would it be possible for us to get a Reported-by
        tag on the patch?<br>
        <br>
        Best,<br>
        Joonkyo<br>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Fri, Mar 8, 2024 at 4:32 PM
          Joonkyo Jung &lt;<a href="mailto:joonkyoj@yonsei.ac.kr" moz-do-not-send="true" class="moz-txt-link-freetext">joonkyoj@yonsei.ac.kr</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div>
            <div dir="ltr">Hi Vitaly,<br>
              <br>
              No worries, thank you for working on the patches!<br>
              <br>
              I have also confirmed that with the inflight patch, issue
              No.1 (use-after-free) seems to be resolved.<br>
              However, I have reproduced issue No.3
              (slab-use-after-free) even with the patch for issue No.1
              applied - if it's the first program tested after reboot.<br>
              (i.e., if any other bugs are tested before the
              slab-use-after-free, it does not reproduce).<br>
              <br>
              Could you check if the bug reproduces in this condition
              for you too?<br>
              I will check and see why this is happening and update you
              if I have something new.<br>
              <br>
              Thank you!<br>
              <br>
              Best,<br>
              Joonkyo</div>
          </div>
          <div>
            <div dir="ltr"><br>
              <br>
              <br>
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">On Fri, Mar 8, 2024 at
                  12:45 PM vitaly prosyak &lt;<a href="mailto:vprosyak@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">vprosyak@amd.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                  <div>
                    <p>Hi Joonkyo,<br>
                      Sorry for the delay. <br>
                      Yes, sure, I reproduced issue 2 (null-ptr-deref in
                      amdgpu) and I will provide the fix soon.<br>
                      However, issue No. 3 is no longer reproducible if
                      the recent patch inflight is applied which fixes
                      issue No 1.</p>
                    <p>Do you see the same behavior?<br>
                    </p>
                    <p>Thanks in advance, Vitaly<br>
                    </p>
                    <div>On 2024-03-07 20:18, Joonkyo Jung wrote:<br>
                    </div>
                    <blockquote type="cite">
                      <div>
                        <div>
                          <div dir="auto" style="font-family:-apple-system,helveticaneue;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">Hello,&nbsp;</div>
                          <div dir="auto" style="font-family:-apple-system,helveticaneue;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">thank
                            you for patching the first bug we have sent!</div>
                          <div dir="auto" style="font-family:-apple-system,helveticaneue;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)"><br>
                          </div>
                          <div dir="auto" style="font-family:-apple-system,helveticaneue;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">Just
                            a quick touch base with you, to ask if there
                            has been any update on our other two bugs.</div>
                          <div dir="auto" style="font-family:-apple-system,helveticaneue;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">They
                            were each sent with emails titled&nbsp;</div>
                          <div dir="auto" style="font-family:-apple-system,helveticaneue;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">&quot;Reporting
                            a slab-use-after-free in amdgpu&quot; (this one)</div>
                          <div dir="auto" style="font-family:-apple-system,helveticaneue;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">&quot;Reporting
                            a null-ptr-deref in amdgpu&quot;.&nbsp;</div>
                          <div dir="auto" style="font-family:-apple-system,helveticaneue;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)"><br>
                          </div>
                          <div dir="auto" style="font-family:-apple-system,helveticaneue;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">Thank
                            you!&nbsp;</div>
                          <div dir="auto" style="font-family:-apple-system,helveticaneue;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)"><br>
                          </div>
                          <div dir="auto" style="font-family:-apple-system,helveticaneue;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">Best,&nbsp;</div>
                          <div dir="auto" style="font-family:-apple-system,helveticaneue;font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">Joonkyo</div>
                        </div>
                        <br>
                      </div>
                      <div><br>
                        <div class="gmail_quote">
                          <div dir="ltr" class="gmail_attr">2024년 2월 16일
                            (금) 오후 6:22, Joonkyo Jung &lt;<a href="mailto:joonkyoj@yonsei.ac.kr" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">joonkyoj@yonsei.ac.kr</a>&gt;님이
                            작성:<br>
                          </div>
                          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                            <div dir="ltr">Hello,<br>
                              <br>
                              We would like to report a
                              slab-use-after-free bug in the AMDGPU DRM
                              driver in the linux kernel v6.8-rc4 that
                              we found with our customized Syzkaller.<br>
                              The bug can be triggered by sending two
                              ioctls to the AMDGPU DRM driver in
                              succession.<br>
                              <br>
                              In amdgpu_bo_move, struct ttm_resource
                              *old_mem = bo-&gt;resource is assigned.<br>
                              As you can see on the alloc &amp; free
                              stack calls, on the same function
                              amdgpu_bo_move,<br>
                              amdgpu_move_blit in the end frees
                              bo-&gt;resource at
                              ttm_bo_move_accel_cleanup with
                              ttm_bo_wait_free_node(bo, man-&gt;use_tt).<br>
                              But amdgpu_bo_move continues after that,
                              reaching trace_amdgpu_bo_move(abo,
                              new_mem-&gt;mem_type,
                              old_mem-&gt;mem_type) at the end, causing
                              the use-after-free bug.<br>
                              <br>
                              Steps to reproduce are as below.<br>
                              union drm_amdgpu_gem_create *arg1;<br>
                              <br>
                              arg1 = malloc(sizeof(union
                              drm_amdgpu_gem_create));<br>
                              arg1-&gt;in.bo_size = 0x8;<br>
                              arg1-&gt;in.alignment = 0x0;<br>
                              arg1-&gt;in.domains = 0x4;<br>
                              arg1-&gt;in.domain_flags = 0x9;<br>
                              ioctl(fd, 0xc0206440, arg1);<br>
                              <br>
                              arg1-&gt;in.bo_size = 0x7fffffff;<br>
                              arg1-&gt;in.alignment = 0x0;<br>
                              arg1-&gt;in.domains = 0x4;<br>
                              arg1-&gt;in.domain_flags = 0x9;<br>
                              ioctl(fd, 0xc0206440, arg1);<br>
                              <br>
                              The KASAN report is as follows:<br>
==================================================================<br>
                              BUG: KASAN: slab-use-after-free in
                              amdgpu_bo_move+0x1479/0x1550<br>
                              Read of size 4 at addr ffff88800f5bee80 by
                              task syz-executor/219<br>
                              Call Trace:<br>
                              &nbsp;&lt;TASK&gt;<br>
                              &nbsp;amdgpu_bo_move+0x1479/0x1550<br>
                              &nbsp;ttm_bo_handle_move_mem+0x4d0/0x700<br>
                              &nbsp;ttm_mem_evict_first+0x945/0x1230<br>
                              &nbsp;ttm_bo_mem_space+0x6c7/0x940<br>
                              &nbsp;ttm_bo_validate+0x286/0x650<br>
                              &nbsp;ttm_bo_init_reserved+0x34c/0x490<br>
                              &nbsp;amdgpu_bo_create+0x94b/0x1610<br>
                              &nbsp;amdgpu_bo_create_user+0xa3/0x130<br>
                              &nbsp;amdgpu_gem_create_ioctl+0x4bc/0xc10<br>
                              &nbsp;drm_ioctl_kernel+0x300/0x410<br>
                              &nbsp;drm_ioctl+0x648/0xb30<br>
                              &nbsp;amdgpu_drm_ioctl+0xc8/0x160<br>
                              &nbsp;&lt;/TASK&gt;<br>
                              <br>
                              Allocated by task 219:<br>
                              &nbsp;kmalloc_trace+0x211/0x390<br>
                              &nbsp;amdgpu_vram_mgr_new+0x1d6/0xbe0<br>
                              &nbsp;ttm_resource_alloc+0xfd/0x1e0<br>
                              &nbsp;ttm_bo_mem_space+0x255/0x940<br>
                              &nbsp;ttm_bo_validate+0x286/0x650<br>
                              &nbsp;ttm_bo_init_reserved+0x34c/0x490<br>
                              &nbsp;amdgpu_bo_create+0x94b/0x1610<br>
                              &nbsp;amdgpu_bo_create_user+0xa3/0x130<br>
                              &nbsp;amdgpu_gem_create_ioctl+0x4bc/0xc10<br>
                              &nbsp;drm_ioctl_kernel+0x300/0x410<br>
                              &nbsp;drm_ioctl+0x648/0xb30<br>
                              &nbsp;amdgpu_drm_ioctl+0xc8/0x160<br>
                              <br>
                              Freed by task 219:<br>
                              &nbsp;kfree+0x111/0x2d0<br>
                              &nbsp;ttm_resource_free+0x17e/0x1e0<br>
                              &nbsp;ttm_bo_move_accel_cleanup+0x77e/0x9b0<br>
                              &nbsp;amdgpu_move_blit+0x3db/0x670<br>
                              &nbsp;amdgpu_bo_move+0xfa2/0x1550<br>
                              &nbsp;ttm_bo_handle_move_mem+0x4d0/0x700<br>
                              &nbsp;ttm_mem_evict_first+0x945/0x1230<br>
                              &nbsp;ttm_bo_mem_space+0x6c7/0x940<br>
                              &nbsp;ttm_bo_validate+0x286/0x650<br>
                              &nbsp;ttm_bo_init_reserved+0x34c/0x490<br>
                              &nbsp;amdgpu_bo_create+0x94b/0x1610<br>
                              &nbsp;amdgpu_bo_create_user+0xa3/0x130<br>
                              &nbsp;amdgpu_gem_create_ioctl+0x4bc/0xc10<br>
                              &nbsp;drm_ioctl_kernel+0x300/0x410<br>
                              &nbsp;drm_ioctl+0x648/0xb30<br>
                              &nbsp;amdgpu_drm_ioctl+0xc8/0x160<br>
                              <br>
                              The buggy address belongs to the object at
                              ffff88800f5bee70<br>
                              &nbsp;which belongs to the cache kmalloc-96 of
                              size 96<br>
                              The buggy address is located 16 bytes
                              inside of<br>
                              &nbsp;freed 96-byte region [ffff88800f5bee70,
                              ffff88800f5beed0)<br>
                              <br>
                              Should you need any more information,
                              please do not hesitate to contact us.<br>
                              <br>
                              Best regards,<br>
                              Joonkyo Jung<br>
                            </div>
                          </blockquote>
                        </div>
                      </div>
                    </blockquote>
                  </div>
                </blockquote>
              </div>
            </div>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------FCGVtaxqKkqMkNURYCxGLqx9--
