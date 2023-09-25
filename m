Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF491CE7A94
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 13:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D06A10E177;
	Mon, 25 Sep 2023 13:19:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9125110E177
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 13:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ji+vg7BavVHAVhHArRIPh57BraQBTI5hNZqduh7e4peC6h7aUbr/j7fT16M0WU25rnqIi7eS6OsH8Md5zh5WV1rSfXslKq60Dll96a6aWk4DNM5MbKSdg3gyC9RgtvfRUhs7OMpT2WXgxY/sW/m9LhpQ8B/s0jAKDS/ckMzFon6Po0jttWLhaiRHEOdH+7tbU0I1UGpv6PN8u1EdmJUdvlDqMkPKad+IMm/06amzlp19WGF8kpA5HmZ0a55J9Z/mhoyoPZexLm+XtYreFSNO7AjWrnTK5G5N9un3Si4DIByzCVoQ6l7U6TV//wbtmBqxsUSm0hvb94gvzVEKMMQaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VQLVw5BcIvMkG+oOpS2EU3pdWMWERRhvcL9V34ljc8=;
 b=XnR1mVjnawIqsBwJcsv/jniIFiJFNy4xyAU49RTIHkv6d1i7o59vFENbgen3uC1PSUe87+cBzNpCa21BB+uRTg6/YNC1Iacncul4CGA6v1wjpabHaqstrRIzgO81tJOI6MM+JCIgpwCPQLI6OGhOkfohx84ZyUAMB0az9kv5X3TB+/iH7vxr3bwiGGB53eWtT87kqeY+mLCvAyFdum0Ab7hnU8hGRjx8/DMx57bHf8OewK6XOctwfIP94RgrPnrydq6r7pvGGpN3Bb3Z0VVn4gwGPmonkIK7J5qqkTNj04lpy8QJ5kTqvETIyr3hoiwCYzSj8B0EcIfkP6kviMqL1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VQLVw5BcIvMkG+oOpS2EU3pdWMWERRhvcL9V34ljc8=;
 b=DUO2/hs+WttegKwMQjpSIDym+EaTxfYByfblwpkitndpRuNyX83sL2HGWrpAPiCYhDQib3KiYAebw9O/9CdcFX8q2ie7sZ4oJUOf/lNRb0UIE0qKPqzr/4UR6jvJu3gQ9Mcy9bb7R5EK1B+ePRp/qudOjd4Cax+1VWhEapkUIwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 13:19:24 +0000
Received: from CH0PR12MB5138.namprd12.prod.outlook.com
 ([fe80::ad06:f79c:92be:1815]) by CH0PR12MB5138.namprd12.prod.outlook.com
 ([fe80::ad06:f79c:92be:1815%4]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 13:19:23 +0000
Message-ID: <9cebe197-6708-6da7-48de-4ce30ee372a6@amd.com>
Date: Mon, 25 Sep 2023 09:19:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix the svm_bo refcount waring
Content-Language: en-US
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230925093230.3891970-1-jesse.zhang@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20230925093230.3891970-1-jesse.zhang@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: YQXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::31) To CH0PR12MB5138.namprd12.prod.outlook.com
 (2603:10b6:610:bd::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5138:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ffd324-caee-47bb-988b-08dbbdca091f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGvWpIt/zmi+5fOBNGdnifTDvmKNfhCt8TPcPTBtHtAeRZXjG1LFBNnnRacvezgCBiL1mjD0SRkewxkitahY+mMCaxptsXyMAp2deHp0+f7pO6hGJEvvVhQ5db0SDGfR7x81t3MGalzrjreoCPvGf7sR8ft86sJdJ+/xhP5SrRiTxxIcMu+WHpJ12mwtlXFImM+jS2glmxXwBGyFvxwb6CWipmOamn9TmjVcvmtHQ02fW4pTPtoK4TSDs2kPwv+LUEbia2xZPd4NdX/q1rtTVwHDN/aoxv7qDuDssrXaAeftbd0fmB8NOtC3yY1G1To01GDXVcAlUeMlScFm7g/ZxO7tpQSv3lRO8Wu4iaq2CLmxmEfqcc6yTHMNjCk4arR0O+XroRIzgohxDLjO/pWmg+nmhWnk/jKrUAp5OSkdV/L7rH9GlKjmRZg/CKg7Sz1DjMh4dGzvQl2Ne8WWQO/+5fcC2pZ3k+IT32p841KBCcvAtQQ+guTb3/CoFGcWNU0wjS7o2TwoXk1pVK8z/KxGKVw6zRoT0j5QgQ4/fE4xcOylhsaM8BeDYz17nNR/8j4bwwjKQncEmzwlXcEIL/e7cBuyCvulVH0RdHvQyDA+9URBnlLr+nL28d9SvvEy4QfchNzm3kBnlxagR+gc5NXJ5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(230922051799003)(186009)(1800799009)(451199024)(2616005)(26005)(6506007)(6486002)(6512007)(53546011)(38100700002)(36756003)(31696002)(83380400001)(8936002)(41300700001)(316002)(8676002)(66946007)(66476007)(66556008)(5660300002)(2906002)(31686004)(45080400002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVM5TmpxVzBHNG9jS1JnK0J4QkdMS3p0SEtua2FnM2lROVBrT3BPM3VZU3Jt?=
 =?utf-8?B?Yk5FOG5DbmU2b281M2NFOEtBVVFKaTRuS3pueUUrUHRrVjJ4S3lBNGZKUDIx?=
 =?utf-8?B?WktkVjZJa1JPZWZZNU81YnFNWll6TXd1bWNYc2s4VzB6eGFMd1BmbjZTWVM5?=
 =?utf-8?B?UEpzWSttWUVjM1pleWZSZ25GTFg5RWNZcmhMS2RnZG1VN2QxY3R3OTQyREVX?=
 =?utf-8?B?NkNyU09mbjFlMERyNU9vVVNnZE1Jc2hxeWFObHVWbjdSbTg5UW1CK0xkREhx?=
 =?utf-8?B?Y2k5cXEvRHZ3ZzEzOTVCYVgvVDFRRzhrUHdjQi9jSk1vSkE4SEhyWWxjZGlr?=
 =?utf-8?B?OGpraGt4ZFdYa1FpT3pqbFZmSmxleTZzRk9DK2ZVUk1JUVRXU3QwWGwyWkd4?=
 =?utf-8?B?RDdrRzhxLzBpdEpoL1dqTXdrUzBEcTk0SXZ5VEdaZWRHUkhFZUVXMGJCRWNu?=
 =?utf-8?B?SzVEMzF2a2paOVpHR2VjanF1aXlGV1NQVWFPZEUvdThLSkRJOHB4QTVSVWxo?=
 =?utf-8?B?SEc4cXg5VTBTVmQyd1A5K0VSRWhkMjk2ci9kY3dYN0xWRDI3akd6enhwNTdY?=
 =?utf-8?B?WVdraTcvdnhqbG1vZHlkN3pWL1dncWF6NWtTYm12cU9vZmJuYXNiUndQME4r?=
 =?utf-8?B?NmtwOWZZc1ZNYUpwV3UvbldHMWgzb1VxNm9xUXNWVXRFcC81b25DSWNpYkly?=
 =?utf-8?B?OGI3TUJJMzFKRzZWak0yZUlsVXFpMWFPSElKb2xTc0kzbUd0UUlzalhkNE5j?=
 =?utf-8?B?TnZqSWhJZVpQZExFWkxmR2xZQUNkbVJjQ2RKSXNuNkdLcHJ3cWdaNnExTDJY?=
 =?utf-8?B?KzgrczBocTlKMkR0SklZM3RVOFNieGlFUXJhRmtiYnJrTnBmUzBJK1Ribzly?=
 =?utf-8?B?d0JDZGhLRnp0NWNSemFDREE0UGV0c3lyQk82dGdzakY3YjNpNG93WEZpWitm?=
 =?utf-8?B?NFdRc09TS1hlWXRPWGhJQ0NvakQzQ0V0WHpUMGEvSlkwelJ1a0c0ZGhNRE9I?=
 =?utf-8?B?L1JFRk00eFdvQ3lMT3V1SDN6VW5HQ1ZoN2JrcnlMUnBQWVcwdnBmWExhbnZT?=
 =?utf-8?B?NURJL0FhN0V6dldUQ2UrR1VBclJ4YlVZTmdId3pSaFZHL09vVkRKQ1hLUTRY?=
 =?utf-8?B?MzViRHVkc0I3U3pjZGdYUXg1SFQvM0NvcXVibDhoMXlMUSs4aXVqWURZSDk1?=
 =?utf-8?B?QVFldnFIQkYvTmZQN0dnN29XcUQ3NjUxWjBUWmNvc3ltQWlEMDBSUzFTR3Y2?=
 =?utf-8?B?R00wZ1owVjZ4UG5SVndqdHhWUmJBcmJLaDdDczBZdU1Sd0Y4T1FveFhKbkJO?=
 =?utf-8?B?dm9xTUpUUllrbWROaEtCQTZ0ektEejUwTUg2MUZSVm5hcUpLVFZ5S2djc0h3?=
 =?utf-8?B?VThvU0xxd0xnek9KT0IzZTlrV2h1Y2xHMW52MnlMWTBnU1Y1a01Jb0JmWWla?=
 =?utf-8?B?MlhqZFNoaGhjUHpTV2x5bzlyeXl4b2tPNXFNRmZwSG9LVktBa0JaOGh4VDZQ?=
 =?utf-8?B?bEdyMWJ3LytyalRWemlVN2hXM2FxOGNxRHNHK2JVa3prdTNHZW1HUHZuR1Ru?=
 =?utf-8?B?WlY0dmpZR09wMXZDdUg3RzYyendzK21yMXNSbGNTOS91OHJBcExjdWNqR2xL?=
 =?utf-8?B?dEJac21jZjRid0xDNGJiYVJ6L09PVXlRQ010cEZkdmR6ZUlSQnNLYUZFaUxm?=
 =?utf-8?B?dGhvMm5aT1U0ckFseUI3RHc5RVRFNXdjYWM4K3o1MWF3UkVpQ3JGTWVGZVBy?=
 =?utf-8?B?VlJMeXVCSnNTRW0yVkZkdEhrUFJwV01lRmxkZkhmOVhCU1BzeVp0ajUzeDFC?=
 =?utf-8?B?K1VJc3BVdWZqckw1eC9mb2JXSlBaQWpVd2IxMU1PdUFjMUJrV0JCbDF0VUlt?=
 =?utf-8?B?N3FjZWJpQzdIR2k0aTJvNk5LQ2pPOGRveDJHQVRJMC9QK1c4d1NEQVlkTlZK?=
 =?utf-8?B?VTlmckxOcnNrS2pIZ0VWN1pQWTJJdmRSbnJvL1dCbFVYbnBRa3g2ZGtGT2Fp?=
 =?utf-8?B?YjAwbGNRNy80SW5la2tNeFBZNVowQXlldHZmbnRsYTFLRG96U1pIU0dVU1Nx?=
 =?utf-8?B?UVRQR1pVWU93Y0NVcnE3V1FoOTd1ajczUVZBbDZPRGtWWnJidnJNRVJJUjJr?=
 =?utf-8?Q?MwLg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ffd324-caee-47bb-988b-08dbbdca091f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 13:19:23.8623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkqenk3LCuu+KuQq8DHN3exPh7rasCurLQwCdkEtsYsHLNDpsJ42lU7RhNaW5XEc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259
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

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 2023-09-25 05:32, Jesse Zhang wrote:<=
br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:20230925093230.3891970-1-jesse.zh=
ang@amd.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">Fix the svm_bo refcount warngi=
ng by check the refcount before release.

[  462.649530] ------------[ cut here ]------------
[  462.649532] refcount_t: underflow; use-after-free.
[  462.649536] WARNING: CPU: 7 PID: 1936 at lib/refcount.c:28 refcount_warn=
_saturate+0xf8/0x150
[  462.649542] Modules linked in: amdgpu(E) amdxcp drm_buddy gpu_sched drm_=
suballoc_helper drm_ttm_helper ttm(E) drm_display_helper cec rc_core drm_km=
s_helper i2c_algo_bit syscopyarea sysfillrect sysimgblt rpcsec_gss_krb5 aut=
h_rpcgss nfsv4 nfs lockd grace fscache netfs tls r8153_ecm cdc_ether usbnet=
 r8152 mii joydev input_leds snd_hda_codec_realtek snd_hda_codec_generic le=
dtrig_audio snd_hda_codec_hdmi hid_generic intel_rapl_msr snd_hda_intel int=
el_rapl_common snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec edac_mce_a=
md snd_hda_core usbhid snd_hwdep kvm_amd hid kvm snd_pcm sunrpc crct10dif_p=
clmul ghash_clmulni_intel snd_seq_midi sha512_ssse3 snd_seq_midi_event aesn=
i_intel snd_rawmidi crypto_simd cryptd snd_seq rapl snd_seq_device snd_pci_=
acp5x snd_timer snd_rn_pci_acp3x wmi_bmof snd_acp_config snd snd_soc_acpi s=
oundcore ccp snd_pci_acp3x k10temp mac_hid amd_pmc sch_fq_codel binfmt_misc=
 msr parport_pc ppdev lp drm parport efi_pstore ip_tables x_tables autofs4 =
thunderbolt crc32_pclmul nvme i2c_piix4 nvme_core xhci_pci
[  462.649576]  xhci_pci_renesas video wmi
[  462.649577] CPU: 7 PID: 1936 Comm: kworker/7:3 Tainted: G            E  =
    6.3.7+ #25
[  462.649579] Hardware name: AMD Splinter/Splinter-PHX, BIOS WS43906N_857 =
09/04/2023
[  462.649580] Workqueue: events svm_range_deferred_list_work [amdgpu]
[  462.649771] RIP: 0010:refcount_warn_saturate+0xf8/0x150
[  462.649773] Code: eb a1 0f b6 1d 7c 58 c7 01 80 fb 01 0f 87 11 64 83 00 =
83 e3 01 75 8c 48 c7 c7 a0 00 bc b6 c6 05 60 58 c7 01 01 e8 48 1f 9a ff &lt=
;0f&gt; 0b e9 72 ff ff ff 0f b6 1d 4b 58 c7 01 80 fb 01 0f 87 ce 63 83
[  462.649773] RSP: 0018:ffffb6660603bd88 EFLAGS: 00010286
[  462.649774] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00027
[  462.649775] RDX: 0000000000000027 RSI: ffffb6660603bc48 RDI: ffff91f77e7=
e1548
[  462.649776] RBP: ffffb6660603bd90 R08: 0000000000000003 R09: 00000000000=
00001
[  462.649776] R10: 0000000000000001 R11: 0000000000000028 R12: ffff91f453f=
b2000
[  462.649777] R13: 00000007f7cfc4c4 R14: ffff91f451f2f480 R15: 00000007f7c=
fc4c1
[  462.649777] FS:  0000000000000000(0000) GS:ffff91f77e7c0000(0000) knlGS:=
0000000000000000
[  462.649778] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  462.649778] CR2: 00007f7cfc4c9000 CR3: 0000000113c52000 CR4: 00000000007=
50ee0
[  462.649779] PKRU: 55555554
[  462.649779] Call Trace:
[  462.649780]  &lt;TASK&gt;
[  462.649782]  ? show_regs+0x6c/0x80
[  462.649784]  ? refcount_warn_saturate+0xf8/0x150
[  462.649786]  ? __warn+0x93/0x150
[  462.649788]  ? refcount_warn_saturate+0xf8/0x150
[  462.649789]  ? report_bug+0x1c6/0x1e0
[  462.649791]  ? irq_work_queue+0x14/0x50
[  462.649794]  ? handle_bug+0x46/0x80
[  462.649796]  ? exc_invalid_op+0x1d/0x80
[  462.649797]  ? asm_exc_invalid_op+0x1f/0x30
[  462.649799]  ? refcount_warn_saturate+0xf8/0x150
[  462.649800]  ? refcount_warn_saturate+0xf8/0x150
[  462.649801]  svm_range_free+0xeb/0xf0 [amdgpu]
[  462.649907]  svm_range_handle_list_op+0x1ae/0x1e0 [amdgpu]
[  462.650000]  svm_range_deferred_list_work+0x149/0x2c0 [amdgpu]
[  462.650091]  process_one_work+0x21c/0x430
[  462.650094]  worker_thread+0x4e/0x3c0
[  462.650095]  ? __pfx_worker_thread+0x10/0x10
[  462.650096]  kthread+0xf2/0x120
[  462.650098]  ? __pfx_kthread+0x10/0x10
[  462.650099]  ret_from_fork+0x29/0x50
[  462.650101]  &lt;/TASK&gt;
[  462.650102] ---[ end trace 0000000000000000 ]---

Signed-off-by: Jesse Zhang <a class=3D"moz-txt-link-rfc2396E" href=3D"mailt=
o:Jesse.Zhang@amd.com">&lt;Jesse.Zhang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index fcdde9f451bb..44c3f22cb4a1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -436,7 +436,7 @@ void svm_range_bo_unref_async(struct svm_range_bo *svm_=
bo)
=20
 static void svm_range_bo_unref(struct svm_range_bo *svm_bo)
 {
-	if (svm_bo)
+	if (svm_bo &amp;&amp; kref_read(&amp;svm_bo-&gt;kref))</pre>
    </blockquote>
    <p>This just workaround the issue, looks like it is user-after-free
      bug or svm_bo refcount leaking, we should fix the root cause.</p>
    <p>The kernel seems from tip amd-staging-drm-next, is this
      regression?<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:20230925093230.3891970-1-jesse.zh=
ang@amd.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">
 		kref_put(&amp;svm_bo-&gt;kref, svm_range_bo_release);
 }
=20
</pre>
    </blockquote>
  </body>
</html>
