Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF30AC7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 15:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 397C610E3D7;
	Mon, 23 Jun 2025 15:23:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s1+karnX";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F2AE10E3D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 15:23:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dB1aP6q/WvH1aE8xTc4BoXqlNxE57htHoQMT3AkikLGmBMrOBAqvnvEKqh9B0Vq2eWjL/iCJywirzUjziOfXUwbksf74Eb7Xgb1XyYQRUiA8ieasBxzBuXni8TmxrAysyCp0+ygSWX5M8KaBYmJbN22cH1tFfWzeCmRLQTnppB3Y+C9dTJqLiSjmkPa5chKK0/T2xzrtoXe0/m1SjGrJLpKePXLKZnznxMI91+2yPK5q/MccGTEjXvR6rFingQIp2dhDWjNbkJnoyRQJEIyfJswmPHMuQ4H5DQgdcejB9iFypTHN8qC9IZlTDeUEn//WA4FIE4LIhEHUd2FWSWzFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4UEyXbHhKWsPsiiN+FDNRjrp3C9K97VE5cxJ/lX37g=;
 b=wErj++hKwUmN99Rvps/bexp85XKGTFWCYUpDWtyxqgtLLzteHuqx8JbhDM+A4ZMKvTDhCm3Z5lUT3lJCtxgqay7w3i+kZcqLgtXtHy0PEQ6FI1yyzkSi1Lb/J3a1cZLy5hiehtWgOayWOZgP2pkydEkLkeq4kc7vYjZcUN1nJxnWW5djZbTZcscwaYx7TKCDS2EUyweYzYw2iQohtWs98/S/196F1rAuqBocHbzJUeXuzVYSZAdPdMuD4Fv67RRqTfloJkHUd9qYVNmI1+hUiiKzU2GLxmdRVWP45RyrhEJ2d9gB0KbL/48TMXttoarlTC061L87qnGHwB/AGY6e0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4UEyXbHhKWsPsiiN+FDNRjrp3C9K97VE5cxJ/lX37g=;
 b=s1+karnXMW4eLf52KQbxsLOcAlR5PL1oBc0m0Hbqg8YdGayrxKj3sRQsIy1F5LOUwhLSzefvOhWzj2xHoJPGOuBc3JZIeq49onl9irLfKL9Hv5QwR7faT+8d99It3wAWxr/YmewKB5b6xaYpSjICWG/vgx/WWp3457e1+CMvacs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Mon, 23 Jun
 2025 15:23:36 +0000
Received: from PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e0e7:bd76:e99:43af]) by PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e0e7:bd76:e99:43af%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 15:23:36 +0000
Message-ID: <25c0e980-f6db-43f7-a003-2d2b16c35301@amd.com>
Date: Mon, 23 Jun 2025 11:23:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix slab-use-after-free in
 amdgpu_userq_mgr_fini+0x70c
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
References: <20250619035751.138272-1-vitaly.prosyak@amd.com>
 <CADnq5_NcgpcSc8VzEY9gXC9AZtbNwF1ovog7dHE6ybDsgZLKXw@mail.gmail.com>
 <cb810840-abc5-41de-80af-52cd9fa7169f@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <cb810840-abc5-41de-80af-52cd9fa7169f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:303:2a::28) To PH7PR12MB6420.namprd12.prod.outlook.com
 (2603:10b6:510:1fc::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6420:EE_|SJ2PR12MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb428ee-33f1-47c2-05f0-08ddb269ec22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTg5THk4dkFuV1RNdC9JRkExU0VCZnFSMEZDa3dJVjZrWTB4QytnUTNFandX?=
 =?utf-8?B?UFpsd2xPczRlSldhV3FRdzJHVjBOL3gyUUZ4MTVib3ZkRWdvcDVJdGM4OGRQ?=
 =?utf-8?B?QUltcWIySzBHVFJDRGc4cXRZMXJEdzViQ0VNZzhCTjU5dFZWWmVEZUJmaW45?=
 =?utf-8?B?TXlzajdhNU1aamkzcG90REtaN3dLZmVEVEdTY1ltS21WNEpHS2F2RTVvYTR0?=
 =?utf-8?B?T2w2SHRNcCtQWEd3aHRSWjFwTXkweFFiYmlGYm1BM04yakpZS1F2aUJoQVlB?=
 =?utf-8?B?ZWVqcnJNcWVxUmFnbUdwelFOeENWdTRDNWVZdDRvL1p1YjducnFyZEFsM2hO?=
 =?utf-8?B?clhNR2hPS2xncC9Ram9YbUpNOWw0U0lsREgxajlRTXpWU3E4TGZCalFrd20y?=
 =?utf-8?B?ZklxcStlWlFiWGdpZ281ZWNqKzZhc01HWTEvOUl6TlpQVHRIYk13ZnBpZkpm?=
 =?utf-8?B?ZVEyYzhXbmZNN3FWSHhLQnBnUk1vUjdRY3BGTWk5RC90UkxKNEdZamdETFor?=
 =?utf-8?B?VjZkc0RVb0N1NEdvYWwwUHVtem5RNnVVazVVbWlkZjlzamJGUmUwL1VKaWtZ?=
 =?utf-8?B?NW9tY3I5SFhqL1RHU1R2Nkl4R1QzdjhNa0tQbVJQK0xmRHdQVzNTbWkxNzN5?=
 =?utf-8?B?QWdUTFBSRGFyZ0tSOHFjYU5KN3BRQ2paaVhIcFNQY2tHRlFWZFFtbUhidU9M?=
 =?utf-8?B?a3dBV252OUZkQVZLdS9jSUxzS1RNbHltQlUzdXRMT1NPRFRIYzhOYWdyMnVB?=
 =?utf-8?B?YmFQTktmNmNpQ2FmRndmY3d1a2l4a2JhVkJaMTBJMnBPbS9iVmdwOGFLd1NJ?=
 =?utf-8?B?Z0MxRWwxTVZqL1ltL3ZjbWhzb3VyUmdJT3h2bEF3STlTakFuOHIrR0t3Zk44?=
 =?utf-8?B?OSt4TVhrSzhSVEdMd1BYM2tXV0NZWEtGMUU1UlRkWENUc3p0NDVET1k1NFdS?=
 =?utf-8?B?YXgycnM2QUhmclB3VitlbGZqTlNWTTZVbmdGVEtpRUl4UkJTVStGajgxNHZL?=
 =?utf-8?B?aTdJZFRwVkVzZUFxU2svekpvU3VzZlRjV1RNblZzQWJYTk5MVGQ3bXNUWkYr?=
 =?utf-8?B?Z09MZmlQck1UMHNwZ3lsQTI4eWFzK0ZWSjRPRjU1RCt6cDZzRk9KZWFTaS9z?=
 =?utf-8?B?TzVNN1BKMENHRW9WVVRQNjd3cUgrczlodTZFMGV1cW5GbUFOWUZkUEtjNXMz?=
 =?utf-8?B?R005WlM1Sm1YMGhnMXg5bDlCblVqNXp1anVrQ3gxN0ZFVHo3NCs4T3V0SjQ2?=
 =?utf-8?B?Y21uTXdWVmpPRlpuKzMrenFXTnM2Uy9TZGlsYjgwQkNaY0ZJTUJZRUZ1T29p?=
 =?utf-8?B?ZDRUdDAzbXo2a0xXV3NNVThhQndCNmp2aHFjUXRmcTdqTGV4Wlg5MjExNzN2?=
 =?utf-8?B?cUl0K0V1bFllYnFFYU9uRGJUUXF2OWV3WnVRMFlXVE44SmFVOWxvSWJxc2VN?=
 =?utf-8?B?d0tHWFc0ZXZ2aW5DeTRUNzgybEc4M2lTWTJua3YyTTZpd3hyMWd1Vm8rblZG?=
 =?utf-8?B?ZnV2Y1pYODdacnRhVldxTHFtdGdGaHBiL2FWWlp6S0JpcXNzejh3NlZYVlZG?=
 =?utf-8?B?Y0FScnhMN2YwT0pzUVVkelBNQytCSXFINmlHRTVYL05GZzRTUGltQklwSkhw?=
 =?utf-8?B?UDFhL0g2ODludEdXYm16aTRsNmtxVzl6cjZUMTFQWTMwcURVR2hUdlVwekt1?=
 =?utf-8?B?UzR2UnE4aHBuem9Pc256SDlIYlVQVURnWGlPcFFMTDdQZGZTNFdxYzlEeUZ2?=
 =?utf-8?B?b21TUkVFUG03ZnVTN2FDb0RsVUxpN2JaK2VyNzRLekJqK0VUcE1IY2hIaEFX?=
 =?utf-8?B?ZWpYWWRmWVFqcmk3QkUyengwVGdGRmxIQlBBNVNYNjN4Ujhwd21nYmhEOWxt?=
 =?utf-8?B?MCsxeXRibmZJM0R3Yk1UVWhiYjJYbWFqQWZHSHQyNHp0YkhXSUtHSHdZMGxm?=
 =?utf-8?Q?xmA3XaQubUc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3ErSVpMV05paUZKZXMzN3JqbzdPazdYMURvUHJiYk01SVQ4U2NPbmh2UFVz?=
 =?utf-8?B?WmRSWTBlVHVoUFFiQm1pN3NLRlRwNzhNRTQrTE5ZVG9KSVZJR25UNm9qMzFz?=
 =?utf-8?B?Z0dQeTZGOVpUYUxMYndaQzZGVk9kMnpJdmdhRWlnZVd6T2NaQlNicmNtZ3ZJ?=
 =?utf-8?B?SE96Q0JCa1RidFUvSHYvVU1GOEVJR0NEUURzMmp4c1dVcEZRa2x3TXl4eFdo?=
 =?utf-8?B?VVJIU1VsOE5iUXlDODRnUldXNzE5L3BQTXdZUVZmMTBTbkxBTi9RNC8zUHpl?=
 =?utf-8?B?RE82SjFzd25BTDhkMzJ0N1ZleCtBeUJzVWhCV3hSbElwTXpnZTMwWnpaZGlx?=
 =?utf-8?B?OWtRRTNydFlwTlQ2TjdoVFIrVVdzUkVGNTZZczhIN3piZEdYWlZCYXd5dEVq?=
 =?utf-8?B?bjRkQnBOMThoVC9JVldsNUhOL0w5Y0tiMHlTeWNlYmxyK1A2azZCelBJeXly?=
 =?utf-8?B?eFdCWlB2aERZYUtQVFp1b2krMnB3d0svcGc4aXdWNXA3Y1NRQ1ZRdU1vMEVk?=
 =?utf-8?B?UE0yZWF3WlI5YmRMc2RNdm5zd09IOFJmTzN3ZTIvcjhQaUdtUW5rWEFPQzNu?=
 =?utf-8?B?K2Z4dmhBVDg2dUhxMWtWRUNZTjhjK3owL2RqZVZqZmYrZVJKa1BXY3c1dkhs?=
 =?utf-8?B?cW1nUWtIN0FxVFpsSW9uSE5oUm9TOHhwOFNOUEZFNmZDcVZjZXd6b3d4WExI?=
 =?utf-8?B?LzUvK0FXazFyc3hLbEF3bFM3ait6c0h1NHBxR3daM3dsNTFRaVlyVkFmWXR3?=
 =?utf-8?B?V2YzbUJDYmhHU2tKcllqOGlFWnQwSkhnMk56dDQxVkJWVWFUWTZiRTJaVkph?=
 =?utf-8?B?dXNESmtBSVhSWGdaakdySk1sSEE2ZUo0V1dxUGNCam9RUDQ5WjBkbEZEODg5?=
 =?utf-8?B?T1JNL2k2Mk9lZW5JMjZoWFBxdWV5MEYxazdIdnNBdlROVklWWG1JekxUVlpM?=
 =?utf-8?B?dUpzYjhFWFppS2RNa3RjQ0FhYkQ0dStRbE9TVU1kajFGalc4a0ZKQmpLQWFD?=
 =?utf-8?B?MVhhRWNBRG5YWGZQcURyT094amJQRWp4ZGtic0d0SnprWUNJMW41dVV1a3hJ?=
 =?utf-8?B?YTR4VzArbkxoWGhvcE1ITnY0WHZ1M2ppRkxCaldYdU05V3g0eXpid0I1TGVl?=
 =?utf-8?B?QjR5a0dGRGIzVVBUQmpkMHJxUmhzMnNXajlRdFN1MmxhK2Vka3NWL29kK0Mv?=
 =?utf-8?B?VEcvYmpCUGNRdzZmeUxaV08vOVBMQW1pNEdGV1FFWk56UkVNeGlrVUJBajh6?=
 =?utf-8?B?QnF3NHV4aFprQnN0bXJ0OVNwTnhBUFUvN2JoaHpPYXEzSlp6emNnZ2ZFSUFy?=
 =?utf-8?B?Z3ZHVFlLMG5URWFNSHpVajNTY3BDdTBUMGErZHNMOGJ6UUJ6K0dOb0JuL2k3?=
 =?utf-8?B?d1B5K3lweGxtcENYVUVGTkxuT2wwWU8wdDdXVXFtaFlka2QvZ0xiREhCNnQ1?=
 =?utf-8?B?Z3ZNU3ZkQVpzbWN6NHJEeFVkNjJqcTg4VXpVWGE1Mm5Kcy9wYnJLdEJUTjd6?=
 =?utf-8?B?N2ZuSzVPY2ZGUHJpWU1WSlBtMTQ4dHlFbE9aU21BaWZ2elpjblg4emVhVEFo?=
 =?utf-8?B?VE9saGtXMGJBWFJIMTlSMkxUNldzbTNaZW1wOUY2UmdwaGp6d1lYUFVzQmQv?=
 =?utf-8?B?UWw4aGRiK2F3Q1BiMndhUzM3R3BNZmNCdElsd1ZyTGwra2IzUkRudDdJelhF?=
 =?utf-8?B?NFRZMU4zMkdRK0RTc3FJTHZFRUl5blg3U3p1QlFGeHdONEhncDBzVFRwVnRQ?=
 =?utf-8?B?R05EZUtXemgvclpDTmZTdHZiQ2UxakNwMEczNkxBbVE4Z2hDakF4V0swZlVy?=
 =?utf-8?B?ZjBFak1pWmRnSmVVU25WTEw3VmRzTS9WR1gxRlpSZDhWUUVrTDE0Q1dCTEtH?=
 =?utf-8?B?WlJOYkpRelQyQ1hrc3R3R3NXMjB4NHJCRzY3M2JqWFhqQW5VU2M2bTR1Vy9H?=
 =?utf-8?B?WUY3WjNwN0NYT3BvTlNoNzVvOXpycEtuY3JCdUZPOFhRZzBFaU9nSzFlVk9a?=
 =?utf-8?B?TkRuUi9PVUQ3d1lCY3lQSEJBUWtlS1E5Zk5lWjQ2SjZtMlZhZWxaSXk1aUJx?=
 =?utf-8?B?UzFHZkFRclRvd1ZyVC9qR0JicDdOUkJyU1ZHNDRkeEdFaExUc2h4K1Y2QXB6?=
 =?utf-8?Q?rHw46tLUrlgaZ0RFv9FWiMyBA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb428ee-33f1-47c2-05f0-08ddb269ec22
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:23:36.0760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mbq97zFIx7qr7huPjdT//b/zSatfe+Z+rp+5naon5x4nYLnPy0cwY47khL4vwT6aCPL91vblk3SWFA5CPZcFig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181
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


On 2025-06-23 11:16, Christian König wrote:
> On 20.06.25 15:49, Alex Deucher wrote:
>> On Wed, Jun 18, 2025 at 11:58 PM <vitaly.prosyak@amd.com> wrote:
>>> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>>>
>>> The issue was reproduced on NV10 using IGT pci_unplug test.
>>> It is expected that `amdgpu_driver_postclose_kms()` is called prior to `amdgpu_drm_release()`.
>>> However, the bug is that `amdgpu_fpriv` was freed in `amdgpu_driver_postclose_kms()`, and then
>>> later accessed in `amdgpu_drm_release()` via a call to `amdgpu_userq_mgr_fini()`.
>>> As a result, KASAN detected a use-after-free condition, as shown in the log below.
>>> The proposed fix is to move the calls to `amdgpu_eviction_fence_destroy()` and
>>> `amdgpu_userq_mgr_fini()` into `amdgpu_driver_postclose_kms()`, so they are invoked before
>>> `amdgpu_fpriv` is freed.
>>>
>>> This also ensures symmetry with the initialization path in `amdgpu_driver_open_kms()`,
>>> where the following components are initialized:
>>> - `amdgpu_userq_mgr_init()`
>>> - `amdgpu_eviction_fence_init()`
>>> - `amdgpu_ctx_mgr_init()`
>>>
>>> Correspondingly, in `amdgpu_driver_postclose_kms()` we should clean up using:
>>> - `amdgpu_userq_mgr_fini()`
>>> - `amdgpu_eviction_fence_destroy()`
>>> - `amdgpu_ctx_mgr_fini()`
>>>
>>> This change eliminates the use-after-free and improves consistency in resource management between open and close paths.
>>>
>>> [  +0.094367] ==================================================================
>>> [  +0.000026] BUG: KASAN: slab-use-after-free in amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
>>> [  +0.000866] Write of size 8 at addr ffff88811c068c60 by task amd_pci_unplug/1737
>>> [  +0.000026] CPU: 3 UID: 0 PID: 1737 Comm: amd_pci_unplug Not tainted 6.14.0+ #2
>>> [  +0.000008] Hardware name: ASUS System Product Name/ROG STRIX B550-F GAMING (WI-FI), BIOS 1401 12/03/2020
>>> [  +0.000004] Call Trace:
>>> [  +0.000004]  <TASK>
>>> [  +0.000003]  dump_stack_lvl+0x76/0xa0
>>> [  +0.000010]  print_report+0xce/0x600
>>> [  +0.000009]  ? amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
>>> [  +0.000790]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000007]  ? kasan_complete_mode_report_info+0x76/0x200
>>> [  +0.000008]  ? amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
>>> [  +0.000684]  kasan_report+0xbe/0x110
>>> [  +0.000007]  ? amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
>>> [  +0.000601]  __asan_report_store8_noabort+0x17/0x30
>>> [  +0.000007]  amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
>>> [  +0.000801]  ? __pfx_amdgpu_userq_mgr_fini+0x10/0x10 [amdgpu]
>>> [  +0.000819]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000008]  amdgpu_drm_release+0xa3/0xe0 [amdgpu]
>>> [  +0.000604]  __fput+0x354/0xa90
>>> [  +0.000010]  __fput_sync+0x59/0x80
>>> [  +0.000005]  __x64_sys_close+0x7d/0xe0
>>> [  +0.000006]  x64_sys_call+0x2505/0x26f0
>>> [  +0.000006]  do_syscall_64+0x7c/0x170
>>> [  +0.000004]  ? kasan_record_aux_stack+0xae/0xd0
>>> [  +0.000005]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000004]  ? kmem_cache_free+0x398/0x580
>>> [  +0.000006]  ? __fput+0x543/0xa90
>>> [  +0.000006]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000004]  ? __fput+0x543/0xa90
>>> [  +0.000004]  ? __kasan_check_read+0x11/0x20
>>> [  +0.000007]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000004]  ? __kasan_check_read+0x11/0x20
>>> [  +0.000003]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000004]  ? fpregs_assert_state_consistent+0x21/0xb0
>>> [  +0.000006]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000004]  ? syscall_exit_to_user_mode+0x4e/0x240
>>> [  +0.000005]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000004]  ? do_syscall_64+0x88/0x170
>>> [  +0.000003]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000004]  ? do_syscall_64+0x88/0x170
>>> [  +0.000004]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000004]  ? irqentry_exit+0x43/0x50
>>> [  +0.000004]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000004]  ? exc_page_fault+0x7c/0x110
>>> [  +0.000006]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> [  +0.000005] RIP: 0033:0x7ffff7b14f67
>>> [  +0.000005] Code: ff e8 0d 16 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 73 ba f7 ff
>>> [  +0.000004] RSP: 002b:00007fffffffe358 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
>>> [  +0.000006] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffff7b14f67
>>> [  +0.000003] RDX: 0000000000000000 RSI: 00007ffff7f5755a RDI: 0000000000000003
>>> [  +0.000003] RBP: 00007fffffffe380 R08: 0000555555568170 R09: 0000000000000000
>>> [  +0.000003] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffffffe5c8
>>> [  +0.000003] R13: 00005555555552a9 R14: 0000555555557d48 R15: 00007ffff7ffd040
>>> [  +0.000007]  </TASK>
>>>
>>> [  +0.000286] Allocated by task 425 on cpu 11 at 29.751192s:
>>> [  +0.000013]  kasan_save_stack+0x28/0x60
>>> [  +0.000008]  kasan_save_track+0x18/0x70
>>> [  +0.000006]  kasan_save_alloc_info+0x38/0x60
>>> [  +0.000006]  __kasan_kmalloc+0xc1/0xd0
>>> [  +0.000005]  __kmalloc_cache_noprof+0x1bd/0x430
>>> [  +0.000006]  amdgpu_driver_open_kms+0x172/0x760 [amdgpu]
>>> [  +0.000521]  drm_file_alloc+0x569/0x9a0
>>> [  +0.000008]  drm_client_init+0x1b7/0x410
>>> [  +0.000007]  drm_fbdev_client_setup+0x174/0x470
>>> [  +0.000007]  drm_client_setup+0x8a/0xf0
>>> [  +0.000006]  amdgpu_pci_probe+0x50b/0x10d0 [amdgpu]
>>> [  +0.000482]  local_pci_probe+0xe7/0x1b0
>>> [  +0.000008]  pci_device_probe+0x5bf/0x890
>>> [  +0.000005]  really_probe+0x1fd/0x950
>>> [  +0.000007]  __driver_probe_device+0x307/0x410
>>> [  +0.000005]  driver_probe_device+0x4e/0x150
>>> [  +0.000006]  __driver_attach+0x223/0x510
>>> [  +0.000005]  bus_for_each_dev+0x102/0x1a0
>>> [  +0.000006]  driver_attach+0x3d/0x60
>>> [  +0.000005]  bus_add_driver+0x309/0x650
>>> [  +0.000005]  driver_register+0x13d/0x490
>>> [  +0.000006]  __pci_register_driver+0x1ee/0x2b0
>>> [  +0.000006]  xfrm_ealg_get_byidx+0x43/0x50 [xfrm_algo]
>>> [  +0.000008]  do_one_initcall+0x9c/0x3e0
>>> [  +0.000007]  do_init_module+0x29e/0x7f0
>>> [  +0.000006]  load_module+0x5c75/0x7c80
>>> [  +0.000006]  init_module_from_file+0x106/0x180
>>> [  +0.000007]  idempotent_init_module+0x377/0x740
>>> [  +0.000006]  __x64_sys_finit_module+0xd7/0x180
>>> [  +0.000006]  x64_sys_call+0x1f0b/0x26f0
>>> [  +0.000006]  do_syscall_64+0x7c/0x170
>>> [  +0.000005]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> [  +0.000013] Freed by task 1737 on cpu 9 at 76.455063s:
>>> [  +0.000010]  kasan_save_stack+0x28/0x60
>>> [  +0.000006]  kasan_save_track+0x18/0x70
>>> [  +0.000005]  kasan_save_free_info+0x3b/0x60
>>> [  +0.000006]  __kasan_slab_free+0x54/0x80
>>> [  +0.000005]  kfree+0x127/0x470
>>> [  +0.000006]  amdgpu_driver_postclose_kms+0x455/0x760 [amdgpu]
>>> [  +0.000485]  drm_file_free.part.0+0x5b1/0xba0
>>> [  +0.000007]  drm_file_free+0x13/0x30
>>> [  +0.000006]  drm_client_release+0x1c4/0x2b0
>>> [  +0.000006]  drm_fbdev_ttm_fb_destroy+0xd2/0x120 [drm_ttm_helper]
>>> [  +0.000007]  put_fb_info+0x97/0xe0
>>> [  +0.000006]  unregister_framebuffer+0x197/0x380
>>> [  +0.000005]  drm_fb_helper_unregister_info+0x94/0x100
>>> [  +0.000005]  drm_fbdev_client_unregister+0x3c/0x80
>>> [  +0.000007]  drm_client_dev_unregister+0x144/0x330
>>> [  +0.000006]  drm_dev_unregister+0x49/0x1b0
>>> [  +0.000006]  drm_dev_unplug+0x4c/0xd0
>>> [  +0.000006]  amdgpu_pci_remove+0x58/0x130 [amdgpu]
>>> [  +0.000482]  pci_device_remove+0xae/0x1e0
>>> [  +0.000006]  device_remove+0xc7/0x180
>>> [  +0.000006]  device_release_driver_internal+0x3d4/0x5a0
>>> [  +0.000007]  device_release_driver+0x12/0x20
>>> [  +0.000006]  pci_stop_bus_device+0x104/0x150
>>> [  +0.000006]  pci_stop_and_remove_bus_device_locked+0x1b/0x40
>>> [  +0.000005]  remove_store+0xd7/0xf0
>>> [  +0.000007]  dev_attr_store+0x3f/0x80
>>> [  +0.000006]  sysfs_kf_write+0x125/0x1d0
>>> [  +0.000005]  kernfs_fop_write_iter+0x2ea/0x490
>>> [  +0.000007]  vfs_write+0x90d/0xe70
>>> [  +0.000006]  ksys_write+0x119/0x220
>>> [  +0.000006]  __x64_sys_write+0x72/0xc0
>>> [  +0.000006]  x64_sys_call+0x18ab/0x26f0
>>> [  +0.000005]  do_syscall_64+0x7c/0x170
>>> [  +0.000005]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> [  +0.000013] The buggy address belongs to the object at ffff88811c068000
>>>                which belongs to the cache kmalloc-rnd-01-4k of size 4096
>>> [  +0.000016] The buggy address is located 3168 bytes inside of
>>>                freed 4096-byte region [ffff88811c068000, ffff88811c069000)
>>>
>>> [  +0.000022] The buggy address belongs to the physical page:
>>> [  +0.000010] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88811c06e000 pfn:0x11c068
>>> [  +0.000006] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>>> [  +0.000006] flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
>>> [  +0.000007] page_type: f5(slab)
>>> [  +0.000007] raw: 0017ffffc0000040 ffff88810004c140 dead000000000122 0000000000000000
>>> [  +0.000005] raw: ffff88811c06e000 0000000080040002 00000000f5000000 0000000000000000
>>> [  +0.000006] head: 0017ffffc0000040 ffff88810004c140 dead000000000122 0000000000000000
>>> [  +0.000005] head: ffff88811c06e000 0000000080040002 00000000f5000000 0000000000000000
>>> [  +0.000006] head: 0017ffffc0000003 ffffea0004701a01 ffffffffffffffff 0000000000000000
>>> [  +0.000005] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
>>> [  +0.000004] page dumped because: kasan: bad access detected
>>>
>>> [  +0.000011] Memory state around the buggy address:
>>> [  +0.000009]  ffff88811c068b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> [  +0.000012]  ffff88811c068b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> [  +0.000011] >ffff88811c068c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> [  +0.000011]                                                        ^
>>> [  +0.000010]  ffff88811c068c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> [  +0.000011]  ffff88811c068d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> [  +0.000011] ==================================================================
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>>> Cc: Jesse Zhang <Jesse.Zhang@amd.com>
>>> Cc: Arvind Yadav <arvind.yadav@amd.com>
>> Please add:
>> Fixes: adba0929736a ("drm/amdgpu: Fix Illegal opcode in command stream Error")
>>
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Sorry, I was on vacation last week.
>
> Clear NAK to that here, this will massively break things!

Could you clarify what issues are introduced by this patch? I validated it using NV31 user queues and didn’t observe any problems

Thanks, Vitaly

> Regards,
> Christian.
>
>
>>> v2: drop amdgpu_drm_release() and assign drm_release()
>>>     as the callback directly.(Alex)
>>>
>>> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
>>> Change-Id: I7ab41fd785dcd6f2651c726337ca07519ceae574
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 16 +---------------
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  3 +++
>>>  2 files changed, 4 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 7fd233f160bf..818a49e69aea 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2912,20 +2912,6 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>>>         return ret;
>>>  }
>>>
>>> -static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>>> -{
>>> -       struct drm_file *file_priv = filp->private_data;
>>> -       struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>>> -
>>> -       if (fpriv) {
>>> -               fpriv->evf_mgr.fd_closing = true;
>>> -               amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>>> -               amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>> -       }
>>> -
>>> -       return drm_release(inode, filp);
>>> -}
>>> -
>>>  long amdgpu_drm_ioctl(struct file *filp,
>>>                       unsigned int cmd, unsigned long arg)
>>>  {
>>> @@ -2977,7 +2963,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
>>>         .owner = THIS_MODULE,
>>>         .open = drm_open,
>>>         .flush = amdgpu_flush,
>>> -       .release = amdgpu_drm_release,
>>> +       .release = drm_release,
>>>         .unlocked_ioctl = amdgpu_drm_ioctl,
>>>         .mmap = drm_gem_mmap,
>>>         .poll = drm_poll,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index d2ce7d86dbc8..195ed81d39ff 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -1501,6 +1501,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>>                 amdgpu_vm_bo_del(adev, fpriv->prt_va);
>>>                 amdgpu_bo_unreserve(pd);
>>>         }
>>> +       fpriv->evf_mgr.fd_closing = true;
>>> +       amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>>> +       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>>
>>>         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>>         amdgpu_vm_fini(adev, &fpriv->vm);
>>> --
>>> 2.34.1
>>>
