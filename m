Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A0DD33990
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 16:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8416A10EB60;
	Fri,  5 Dec 2025 16:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mmziMbhU";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012022.outbound.protection.outlook.com
 [40.107.200.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8776810EB60
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 16:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgjw8oTBQUh7XgDuRY1GqhXr2HmDm64ol0XFowVPYSJ4C163IEUnn0p04dSSDpQ4Y/FESXdDTaIeQodgh0RVE/ef4jsT2waScZOfdCJNgdMNgpDsSLQrYOvGw+ZgebtScWKzDA8m2qhE0bZvFAN78x8VYY2gizTU4We6/T2g0iyKiNj2P1pIbkB0xswa+/LXVk0F+/Al4Tg+ou7+j6y7jQkSTf/auigqn1eI7LvwTST23Q+VLvQ+x6YmIMCRoPWil7JMB83YBwkTTWmYe1f3xme0Evqea3m+ZQBVVhk5vYz8vUbPLPnOu4shEvADIhNvtaPhY+1w9u5OwZkzTw0h3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqqU2Mt7jdmJVP+oJ2F1Y4E56kcy1YalS4Xn7k/kZI0=;
 b=jsEXBCPhA7cYwZTF62jyrSVXYJna7Zm/F3+KnVdEcZwhLSR3nanIPR32COo8Ba49BwK9s5QRzEqpyyPSx60LEoiBbw2yXMvzN8uhGmGzYZCm8wLCtxJhiTB3zCVWnVDw6s/2sruY55mmICfy5NsYmluYP78Et+7es7h7TymR0I9RsUj/IdE+VoaqKeU1yxwrXZQr8ExEwOud6VgFGe0CM7Oz+3EgZR1Cjz77sUFTgbo1lMCCKSaxA/o+E3Mghxo8jEUd+2J3xbS+ERwwjR6+dIWv7yTX5EAOUsiqyn12q8HQpxUv/lygczasL11yXyEExbddsEzxYJqU1rlTgHbjWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqqU2Mt7jdmJVP+oJ2F1Y4E56kcy1YalS4Xn7k/kZI0=;
 b=mmziMbhUSgQc8j1W81YtEbWH4ddckRVbEK74MNWuNBXZENG933qd33AfUhdSeZBR5jv5wM1LSebKKUE5YSfmaHO2b2rFumxc0QmVaoSDo1qbb0X+u8eGzV3DbpTRDWb3BUEAzJ0pP/NWMEJhTbDFxcXoH+eEaBWMDydmIWtxhzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 16:45:13 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 16:45:13 +0000
Message-ID: <0e54d5d4-602b-43df-8107-159c4b6e02c5@amd.com>
Date: Fri, 5 Dec 2025 09:45:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: linux-stable 6.17.10 (and 6.18.0) regression - broken DisplayPort
 MST/daisy chaining
To: =?UTF-8?Q?Natalie_Klestrup_R=C3=B6ijezon?= <natalie.roijezon@appva.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <GVZP280MB0725CCBA01C7021B957C708097A7A@GVZP280MB0725.SWEP280.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <GVZP280MB0725CCBA01C7021B957C708097A7A@GVZP280MB0725.SWEP280.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0314.namprd03.prod.outlook.com
 (2603:10b6:303:dd::19) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: 193b8c8f-b688-48a9-ed75-08de341da95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0tybUsxcUZmSzlOWHZPOHNzNjJLMzJaYlh4ZHZYamFncHc1bEZpUmk0ZEk5?=
 =?utf-8?B?Ny9uWWVNc1V3KyttQnovMzBLY28yYzBVVWIxbFRSMmpwRG9tRUxySXBlRlB0?=
 =?utf-8?B?VVhoRVNHeXR6MHp2TVdGYjBiSUFEUkZIZnlydFJXdW9WREtlMjZLVGJ4SnVl?=
 =?utf-8?B?T0xSRkNzVzcvbnIwUjB5V21CU1pheG85d1lyYUxFT2tad2VMQVNNTkJGMldr?=
 =?utf-8?B?M2JDczF2QUNGVEJFWVgxYlJwN0NqaWdLU01qZzhWbWt3R3J1ZE5GdnFzbEV4?=
 =?utf-8?B?MkNRMk1rK2NhaE1jS2lHWjZvSnprdzdNd3JmanBGV040QldSZVNOSVo2K0xa?=
 =?utf-8?B?SDljTW1rOW5wUFF5N0loMU1NMnlBMzUwc0FiakxIRWNCSDUvMlcwbnVJRVJI?=
 =?utf-8?B?RTBWRllicm5yVlR4S0s4azV4cFdsWmFQQ3FBNXFaZmQ4N2pXOWY5Y1ZmU2VG?=
 =?utf-8?B?YVRITWxtM0VDN2trVFNQUW5KKzlkWWJ3ZUY5YkhXb2NKZ0ZmdTF5SjBMKzBm?=
 =?utf-8?B?NTZBNXA5TGpQaWhLcEs3cEVTWUF3dEc4UGY4bUxZdG1BcTQzK2lXR2RoUlJZ?=
 =?utf-8?B?bXZlTXI0Qi9ndFMvWDF4c2lBanFQU2dJcVZRUFpvWlM1VzhKY05xQXhmR2Nh?=
 =?utf-8?B?MTdPaTdHejlGZ3VwdWx4YmRBeTQ4NXdsaGd6TmgyaXBzTVkwZ3JuL3VWSDdl?=
 =?utf-8?B?Q3Axdy9YQnd6YzJsNE1vbmJ1VEtNSk9JNUMwb1phK3pNVHk3d1J4Y2xQUTds?=
 =?utf-8?B?cHNNdi9BNlJ6K25kMWpGUDJ1M3Uvc1NwSFFBMytvYzJnY2d5d0tRVndtSmdS?=
 =?utf-8?B?L1o0ejA0L21aNFBjelRCOFhKTFVoWXgxa3JhQjRGZEdCQXZoM0QzeS9UMzc1?=
 =?utf-8?B?WnhwV2VWNVdtVXgzbWM1ZjZWM0tqRFphbGs4N3pRelJ3MEhRNFAyS0JlUFA1?=
 =?utf-8?B?by9rUzRsWDVGdzhOVFBMSHVXdWpYdURWaTFFS0hiVzU0Ym5icGl4ejZGa2xv?=
 =?utf-8?B?VVMvZFc1U1QyMXp1bUwzWUJDcUxtejVoN1cvZVU2a3BvQ1VIUk1yRjdjMERB?=
 =?utf-8?B?MVhaM0JsSDV4bStOb2Z0WWZDcFJmbUNQQkFYeWg4eXhuOVJ0SGMxblkwd0sw?=
 =?utf-8?B?RGZDOERPZ25kWjBJdG03QjYyRWVLL1pQV205a2dTcUt0eEdQMDB4cHVFSzZG?=
 =?utf-8?B?QWJ5L2tsbUFPcGV4OVcrcU50czQwR3JlKzFaUDFZV3lIdEhaMjNSVVBYYys5?=
 =?utf-8?B?bEdqUyt0SjQ5UUpaTENrWGpoRTBhZlVCMms1ajJZUHpMZnZIaStHNklSYndE?=
 =?utf-8?B?WFFRQWN2NHBDNXI3Q1U1bG1FU2xXcHI5M05ZWjJIbzdraTVBZWJjM0F0Z2cy?=
 =?utf-8?B?eVM3UExWSjBSSnIycTByeHlWN2ZweStLYmY4WmNiM0tDWGN6ZExSa2hXSUNy?=
 =?utf-8?B?Yjg0WFhlZ0cyZjFPLzg4c3FuNzY3MTZzN09LWTRwdmRaZzl1MHVxNXowVUhu?=
 =?utf-8?B?QVNFWHN1d1MxVzhMMEJWT2hIdmxJR0pBcUQwY2MvSE1PWjhEQXM0N0Y1MUFR?=
 =?utf-8?B?YkV5V29HSHlxQ3NkQlVvVTZHRXlzcHJKK1o3Mnc5T1kyanVvSit6VHpZT1Ju?=
 =?utf-8?B?UmdYMFl1Tk81ZDd6Qm9rOHZiUW9BTVNva2FmOGJyQjAyMkViMEtPVm5GVUg3?=
 =?utf-8?B?dVJpOEFLSzA3bmR0NVp6SjFZRDJhdmpMQWxMSnp0V25ycWNIL0pQZXRvajV1?=
 =?utf-8?B?NVFWa3F3U3VlOENEeFNIOC9LSkk1UlliVUNKak0zYTVDZWpnbnh6T3o4VzlL?=
 =?utf-8?B?dERQRkRTOXNvSlRTY2dxTkw4c2VCVHBWbitmbmxFNSsya1NNMGd2NGtxTkUv?=
 =?utf-8?B?ZVNhY0VaWTQ0dEprd2pEdVlPZDh4cHk3dUJTZWlMODZUcWNLdFo3Qk9PYXhG?=
 =?utf-8?Q?BjO6zW4lTP9Z7ogXvyp5mVA1ZJg08KIL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzlkR0lnN0IvNkxnT3ZvblJVKytqUUpOeWpVcVExYlpURjJRdFNDWnMyR2xo?=
 =?utf-8?B?RVloT2Iyam45eDA3N1BEZTZhU1FrUTdQcG1LWmtqS3JsTm1MWEtUa0tSY1lD?=
 =?utf-8?B?V3VNaFlsVUI2TWZLQkM4cVZGL1FhS0lsYklIdjNDOGJob3BSR2VpMm1PVEFC?=
 =?utf-8?B?aTNLd2M2aGJsUU1RQVV3ajFYUWpuanE1V0VvTmdDQmw2bnpzT0JhUW1NSkhN?=
 =?utf-8?B?VENrcTAveFBqM1k5NmZYTHNabjVvelYrcnNOOGhnbEJvbjlhS2h2YnorOGRz?=
 =?utf-8?B?c3VYVTRlOGZZOGEyakViR01kbmtXMklxVGpOTHdleFlQaUcvR2NNQzhyWUx5?=
 =?utf-8?B?ODN2TlRrZm9vQ0xhN2pib2hZblRsR01FVW11d3JVQk1NYm0rUTlGQmVnQ0V6?=
 =?utf-8?B?TERNSkdXNHU2Mnk0ZEhlZDE0VTBUK0lWSVdZZDFHZ2xsV0MvTGkvamRBL25R?=
 =?utf-8?B?UkdWTnZ6ZGM2L3FpNWgvSHpNKzRZSWViSURUcnY1aS85eUpSUU1nMzBYM3Ar?=
 =?utf-8?B?TGFuSGd4MTZ3SlVTV0x6dVVEZDJ4Zi9IeVR2amEramo3Q0pjamJOUGxTZHNo?=
 =?utf-8?B?VUFsSnZ4VWJHK0ZOTlZTYjBmeENWQnJsYnlodzFLTUxPVDJIQjdtOEk4Qmhj?=
 =?utf-8?B?bVcvNDVHZmVCbUo3cGJqS3RpMk4xQ2pZYm9ubTVRa1lvQndLK0JjTXlLVDdn?=
 =?utf-8?B?cDhCampVRmk4SC9yYlBORUR1Umh6UlpOeExkRzVuSE1QaTJDTnlORUZXZTFX?=
 =?utf-8?B?bEkwWFZkRFc4OGNjRmZkR1NnWUlqQ2dhdVlpK1ZGZmlmMmYrbXJybXNzanZk?=
 =?utf-8?B?azBYN2xyZXhGYkhrS0FOTnpBbGNpOUtZLy8vUE1xcXFDbnJWbjdpQnhDVWJy?=
 =?utf-8?B?YUtGWmw2NTNlcWRmRzBTMTdLbVZmU2Y2enRnd2NqYjBOTCsvamptZ2NRb3U3?=
 =?utf-8?B?NFlEc1VDT3VkdDlETmp2eFVDM3VsTUpuenMvanp2UnYvSkpoc29PZk9uV3Jy?=
 =?utf-8?B?VVJ4UjlpcldEc20zVnI3bzVtbzZBYnFPbzEySis3SE9La2pkNUdwbFhwZmdQ?=
 =?utf-8?B?bmZNbG41N0NROEUwaVVobDZKVU1hQkkrcjRLS0c5VE5GdjFqdjhnY2U4b1Rm?=
 =?utf-8?B?VHpSTm5NU3ZSckNQNDRzQjgwOERaMFAxNGJpMXhWbkpNQU5jMlQwZFNyM09I?=
 =?utf-8?B?WEdGYmdHZi9FZzcyNUI3cGVsUVBNeFR3ZE9ZRjhLWERzTzZlMmdGUFJBeEJm?=
 =?utf-8?B?VkpabXIwR3FFb0ppNHlaYjNXUDk3cFA2WEUxWWRPRys0Ylo5eEIyUEM5UmVC?=
 =?utf-8?B?d2FNTkdGK0d1SGVkT1Vzd2owVlNzT2szdzBEMnJqcnpyN2FHVGdMWHREbTN0?=
 =?utf-8?B?cERvdmpETFJ1ZEdYOHRMemZUcWVDQ2hnN0JNOUJmVU5KaG01aHNZM1hnMzJ6?=
 =?utf-8?B?Z1hJWkorOHZ2YlpEM3ExOUs4QTRnTVpaYW1DbExncy8yTTlyRHRRdk01bmFq?=
 =?utf-8?B?elVWSFYxZTRYeWMwMkFXK282bUk2SUFwNUF0NXUvaDFoSlQrTzNrRVY0ZTk1?=
 =?utf-8?B?SDhYOGxPRVBuOHluU0JCYzNLNGo5cVJvUGFhczdGUGJYbjVvbTg4OGg5L2JO?=
 =?utf-8?B?dTRES1VESUZnRlV2OHBIZy85bzN3YkkxU3puejBkWlhJcmwrVVlqdVhVMnY5?=
 =?utf-8?B?YXBYY3cwKzBKRE43T1hYd2JqKy9zcnBMaTZMT2Yza1BLdDh0RW9XbTZ4ejVx?=
 =?utf-8?B?OE14OUFSaFJEdlVUcXFtSjdVTC9VbmtWQ0dyZVhQMW44bkF6VGQrdjFKYUpJ?=
 =?utf-8?B?THVMN2R3ZzdpTDdjbFA4ZlB3cGk0cktONVhpdjQ1Q1N6aFo3Tmx5V0ZiY2lu?=
 =?utf-8?B?czZYcXA2TnlEWU1SVDVMT1AvN2lWSGF6bUhsczluNkFVc3NBSmJoNnRsUW10?=
 =?utf-8?B?cWsrMlVyT3NLajZCb2tQdEVkSHYxZkxmVXVXZWl6OEU1bjNXSktJNXNGUi9x?=
 =?utf-8?B?VlduMEx6U0VZaDdDSzNtb24rNDFTR3E3aUlnN3lPQnduWGtidS83VmJkY3dW?=
 =?utf-8?B?bHJtWklzWUFWT3dwVXpXc2IxZ09Tbkl5Q1FRbndNUDNsOGlUMTFheFc0UDhY?=
 =?utf-8?Q?MaV4HhTYAwpOYGpW5nib050Ax?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193b8c8f-b688-48a9-ed75-08de341da95b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 16:45:13.4834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5/BibBn3/1Gh+jLMdyD3i2BIwBBBsJTC7nFvKB1u0cZgW9SWNMfvj+mZQmeZbkK5nIPvG6X4frX0s8J5fuRJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752
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

Hi,

Can you file a bug to https://gitlab.freedesktop.org/drm/amd/-/issues/ 
so it's easier to track this issue later? Thanks.

I will forward this to patch author at the same time.


On 12/5/25 07:26, Natalie Klestrup Röijezon wrote:
> Hey,
> 
> After upgrading to Linux 6.18.0 I noticed that my daisy-chained display
> setup (Lenovo ThinkPad P16s Gen 4 AMD feeding 3x Dell U2424HE monitors
> over USB-C for the first, and then daisy-chained MST between them for
> the rest, running at 1080p@120Hz) would no longer work:
> displays 2 and 3 in the chain would just show "no DP signal" errors
> instead.
> 
> The same problem also happens on 6.17.10, but 6.17.9 is fine.
> 
> I bisected it down to
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c?h=v6.17.10&id=18030e84cbda014787369b6d4cde8404fa2d08fc
> and have confirmed that it 6.17.10 with
> 18030e84cbda014787369b6d4cde8404fa2d08fc reverted runs fine again,
> and is able to feed all three monitors.
> 
> Now, obviously the patch exists for a /reason/, but at the moment it
> appears to just be trading one miscalculation for another.. would it make
> sense to revert it for now?
> 
> Happy to (try to) assist in troubleshooting, but I'm also woefully
> underinformed about what the numbers are supposed to be instead.
> 
> Thanks,
> Natalie Klestrup Röijezon

