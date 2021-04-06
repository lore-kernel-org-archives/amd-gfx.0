Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC26DC433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 14:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C2F613A9
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 14:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C2F613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DEA96E836;
	Tue,  6 Apr 2021 14:30:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD2D66E836
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 14:30:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCA2nhcR4kVPqe8mRiktNZ8b6Xa4AUZQA5Hy/r80sKCMxWL4xPQ8VO7Gc6M6coAd/iJHGSZO+Q9qiRSBvwPz03DpBCVwDY6JlA84nplbL2jsY2s/IjhhGiG+TMLO+TrCRHFsDW+/vXKBVEhkBdeWIWZ5QN8fAhrwvTvKUYukIdT2YOYDMT6mUPiAvMitB7r1JkS05FqW59HkXIpePYSKy55NNWNFQhPsep6Cu4Ah0CdMxAWqRiCWsAK+ymW7409OYZ+qHjWUbh98kz77ynxJ6pX7cD83UUugSokVJtoDt/6+8pGqsXfURmlD0vYqa2BTeBmEGNwmwdCm0kSrlIhTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITK2Fjr3y6I6/G2dYzs+2hKRZlDxPyxTLEd0drGpB0s=;
 b=S+Aaf9F7J60wYGlJhFZoWZIp5VGKkKfG/lvK8Ti7g3+PWYXiQIaaXDu/Esh2JwnSqLwJ+DuXmbcj1atNCfv4ER044jU4k1ktOqxoZT4QQb/wLAsKuWaD+p4buR/BcrB8ENyUvW3Kx5PHlh9JpoWXKTnYkuxec+mxuKbX3aDzq6KD70p+3kQqANib6P9OnwPe+vqf+2bcuHSWuTo6eXdwrUh9aZ6gbKwVKebdSb5zZrOFc0tIFLIFQRGbMPe4ySdAdze2ajCx03+yV24qFdJais+paio/YhbFez3sPcdGBsIHVybUOTIFaw9+Q3Pcab7C0Cxy8b+TUPN0/WOBrQiP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITK2Fjr3y6I6/G2dYzs+2hKRZlDxPyxTLEd0drGpB0s=;
 b=doGRKSoYLuMSCOoaZzM9nPtudK6bxCM3B11++Uh2mMwFr01D5Ky4Ot9LL1NMUeo6ALOtxiSgg/jnYz86Q0OVis87I4sgPm3Qyt8RESeUVe+W+4WZp6kLdIS1B/a+5ZvMVFFtBLwNcOOJwlA3Tvk4Nw9GhNl8PyZDO/rYN76tnVE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 14:30:17 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98d7:4d47:2cae:38dd]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98d7:4d47:2cae:38dd%5]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 14:30:17 +0000
Subject: Re: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source
 define/complete/debug flag
To: "Shih, Jude" <Jude.Shih@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210406134001.46915-1-shenshih@amd.com>
 <bb10f195-2205-a3a0-498f-94668ddb4bb2@amd.com>
 <MWHPR1201MB2494C84F298E6C540BB76314F7769@MWHPR1201MB2494.namprd12.prod.outlook.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <3c30e17b-c1d5-f949-1286-a5b53c00622b@amd.com>
Date: Tue, 6 Apr 2021 10:30:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <MWHPR1201MB2494C84F298E6C540BB76314F7769@MWHPR1201MB2494.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32 via Frontend Transport; Tue, 6 Apr 2021 14:30:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4b7f6b9-24b4-4c2e-8272-08d8f9087fba
X-MS-TrafficTypeDiagnostic: DM4PR12MB5038:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB50387E0682C6C7620A90B913EC769@DM4PR12MB5038.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 681MuJxPyByyG4Xa4Ffjgf/2/Fd3CMhfLVbpsR6XtP2maMGbmLmgHageAO4r1lUMxgBj1rGFutc+EtGZTGe2RNwjGcWu04KSByOIIgxVA35cPJIGcHqZbvuVM9gPPu6GHTPwnvs522IR+1cScxcaJ+HDBSuJ31pyY3HHwHvbgXr+LXiLKcWU432a+fEFxlQmHi1XDeEoDzujVvr8e8p/2Cr5vhv0RpNdVfWASSumuAlWkkNeI9K4s6hcvkgADskLeTlGc1CfTDMbiPX9sGuJzzPBGhYCzcMGkKzvmN5p8wCYAgMxrs6JgFoBliFLqB9cel4aBeAf6wqNWl7QRQUS37edAHB7se9R2LysGv5Z+xQGEQtg8ghsB4HMFSsWWvv8zuTaYJiQBjjTJ8m82vr1Wxn4DAuzurTFbFwSxLokRHWOrFY2OmhvByD3LHUzUwqp2zYhP7icqS1Uz1tjERDEIbpuEClSF9+iuHdD7vHF4JGCeQUpVEnEreSCaZZnbjHT3JiXkOc4LSFO0tjJSibAYaTXbggd0az9z6uI/MgLnYcx/JyW8nU9ZelzYqaSndy9uumsZqRKlfAHoXyOmLgKZ006xIBCAEThrybM8w6Tjk6hLh3gKKTt660ck2MW3r3ic2UkauT/GTcaVDOjEuJ9ArS+Y4B04G+mTSFvdDU1g65LY8oggeyK1+DlodojHNhzxIZTWGPjLRsioD9y8Gg5BF8tKRd6etIQOazlXfNMNd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(376002)(396003)(136003)(346002)(366004)(956004)(66556008)(66946007)(83380400001)(2616005)(31686004)(478600001)(36756003)(186003)(2906002)(26005)(5660300002)(16526019)(8676002)(16576012)(38100700001)(31696002)(110136005)(54906003)(316002)(86362001)(66476007)(6486002)(4326008)(8936002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?amJiemExS1NKSnZta25QL24vSGhPck1sMGdDdTJ6SU5JU0R4eU54OTcxeE1l?=
 =?utf-8?B?MVdPVVcyZ1drb2JwaU00RzZJYU1SaWJEdnlLa3dpSFJ5dEZ0bHNValVaY1JS?=
 =?utf-8?B?LzEvOWczdWZjNGtXbE5jNEdHL0U4T2djNGNKaFdLV25WbHFaS0ZUbFJ5RS9u?=
 =?utf-8?B?RWJ3REpNYVphOWhsamplL0RHcWRsQllNbEQ5YzdlYXRad0VYWk1UdVM3SHNW?=
 =?utf-8?B?TTZ4SkxZVTdFbmFucjdnaWMxVFIvbTZPa0FYTGVYT2RUSFhMYXV1dDFCbVNJ?=
 =?utf-8?B?bnFmdTNBUWFBOXFKaGdhL0xJaUlSTUZ0cjhhZEluRlJuTVE4bng0TmdnR2c0?=
 =?utf-8?B?UDFsMFhDclVteHhPMGZYQlZtWngzSGZwbnZpT3VtdHhIWm9VSmZ6azJWblM3?=
 =?utf-8?B?REEzN0Znc1g1Z1hiaGExWVRSLzZtaDE5VDI4clZaTGdSZFB6UGZSQTFMbVdU?=
 =?utf-8?B?K29XU1VnMDlVVXFCcnk2NHhvUEpuYVE2QjBpUWZKalpBQlBMc2ZQQU95RkJJ?=
 =?utf-8?B?T2MzMUJHTWV3eS9GMTRlWlJJM3l2NWlnNC9lOW5sS3NhL1J2R1JsbGsvWjBU?=
 =?utf-8?B?OXk2VXhpdTl3NzAxdU1RcXVNVTR2bmxXazRYdEFITTBQNFpMdG1sV1dBVFZO?=
 =?utf-8?B?bHZNQVVML2V2blVFbkptVFlreGdvTjJWaDNWNzFmdERaLzk3cVJnMElSbHRN?=
 =?utf-8?B?YndzcUdhV2VtaGU2OXNEeUVKYWNOZE1neW9LdVBVVG9ENXhyYngyck81UWRm?=
 =?utf-8?B?bCsvajVWOG9aQko3WlhtMkZIbUdjNGxVOXpZc3Ftdi9EaGN3ZysvYnZWbTh3?=
 =?utf-8?B?aEREMml3aTN5Ty9LUEFZajJ6YjRjS1Q0ZUdxK2RwREM0d05lNkxQejZxeEhy?=
 =?utf-8?B?UUlLODB4NHV1UmJTRWw0V2wxRVAxbGI4QjZNam4ydEpVVHlXbXpDaUg3aUtQ?=
 =?utf-8?B?RFZoYUpkNUVqaC9LS3JMOXB0VHZTcjUweWhvM3JlSExNZUFTM3kyNndxcXBn?=
 =?utf-8?B?UXVGL0E1K2JmVzlBQTUvdEJTTC8wcGFjSWtOd2lHa3dMK083YlQ3MVhzdVRW?=
 =?utf-8?B?MS9SSEwrM3hHcDFwVHBGN0tKRmFNdmN0YzVBblpUbzBuWTlya2dLWVV2eENs?=
 =?utf-8?B?Q2VqcGx1bGhZc0RoaUxNMmhpODJWMkVHNVpUZlZBN3E4azJKUHNhKzVVNXJ3?=
 =?utf-8?B?QTNxWXFNQUtIWTl3bDA2SHlKR01pV2dRRlZMNG40Q1Q3M093MVpoRDhUU3hP?=
 =?utf-8?B?aTR2NWRiTUpPWEJDVWNWUGljc0hrT2lpaWtBbkZHUnAyMXl4Q2VOYmNkMmlG?=
 =?utf-8?B?bjNISW05RmJ4Wm5uSzk2dnhVZTBaZFdhR1R1VjBHZk1VMDE0eFFHeks5RXBY?=
 =?utf-8?B?Y1lxb210RjNtQkJCUDRmM1hBQzZTN2thRlBCbmhXcWlvY1BMbFVsNXdyQ3M5?=
 =?utf-8?B?d29JWElsRzk2bDJCbGU3ZnE2c0FNM2tGdjhsZ045ZXhjL00xQ0R2L0ZFUC9Y?=
 =?utf-8?B?TW9DRC9wSnc1di9PZmJib2NuQ0hudTRGYWs3Vjd5djBGMzU5cHFSb0NOMDNa?=
 =?utf-8?B?OTcra0NDQytKc0JESlVtcXV2UkJRNzNidlIvWDNKL3BTZDBxU2FJTTJmU05B?=
 =?utf-8?B?NEUxRXRjdmhmTFVWaUsvcksvSUVHRExFQWx6VVB3RktQWTVaajNIVWhuK3h2?=
 =?utf-8?B?WXE1b21oZXllZm0xSWw5dW9QaTYrS3krNnZPSDhkS29qSDNoN1ZjTFJhczFE?=
 =?utf-8?Q?ipWjwvjAAgrlueagKo5spEXWzWPbpuY+67vye6I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b7f6b9-24b4-4c2e-8272-08d8f9087fba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 14:30:17.2243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvwjSWyVjBj/EG1UbXuB0nMkXan1330LKdAQ+pu6CvEldmpUqFQ8Qw1lY13pQIBoK92PNICY0tdmfeW1Q0mYSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5038
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Hung,
 Cruise" <Cruise.Hung@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-04-06 10:22 a.m., Shih, Jude wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> Hi Nicholas,
> 
> Does this completion need to be on the amdgpu device itself?
> 
> I would prefer if we keep this as needed within DM itself if possible.
> 
> => do you mean move it to amdgpu_display_manager in amdgpu_dm.h as global variable?

There's a amdgpu_display_manager per device, but yes, it should be 
contained in there if possible since it's display code.

> 
> My problem with still leaving this as DC_ENABLE_DMUB_AUX is we shouldn't require the user to have to flip this on by default later. I think I'd prefer this still as a DISABLE option if we want to leave it for users to debug any potential issues.
> => do you mean DC_ENABLE_DMUB_AUX = 0x10 => DC_DISABLE_DMUB_AUX = 0x10
> and amdgpu_dc_debug_mask = 0x10 as default to turn it off?

Don't modify the default debug mask and leave it alone. We can still 
have DC_DISABLE_DMUB_AUX = 0x10 as a user debug option if they have 
firmware that supports this.

Flag or not, we need a mechanism from driver to firmware to query 
whether the firmware supports it in the first place. It's not sufficient 
to fully control this feature with just a debug flag, there needs to be 
a cap check regardless with the firmware for support.

Older firmware won't implement this check and therefore won't enable the 
feature.

Newer (or test) firmware could enable this feature and report back to 
driver that it does support it.

Driver can then decide to enable this based on 
dc->debug.dmub_aux_support or something similar to that - it can be 
false or ASIC that we won't be supporting this on, but for ASIC that we 
do we can leave it off by default until it's production ready.

For developer testing we can hardcode the flag = true, I think the DC 
debug flags here in AMDGPU base driver only have value if we want 
general end user or validation to use this to debug potential issues.

Regards,
Nicholas Kazlauskas

> 
> Thanks,
> 
> Best Regards,
> 
> Jude
> 
> -----Original Message-----
> From: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>
> Sent: Tuesday, April 6, 2021 10:04 PM
> To: Shih, Jude <Jude.Shih@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Hung, Cruise <Cruise.Hung@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source define/complete/debug flag
> 
> On 2021-04-06 9:40 a.m., Jude Shih wrote:
>> [Why & How]
>> We use outbox interrupt that allows us to do the AUX via DMUB
>> Therefore, we need to add some irq source related definition in the
>> header files; Also, I added debug flag that allows us to turn it
>> on/off for testing purpose.
>>
>> Signed-off-by: Jude Shih <shenshih@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h                       | 2 ++
>>    drivers/gpu/drm/amd/include/amd_shared.h                  | 3 ++-
>>    drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h | 2 ++
>>    3 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 963ecfd84347..7e64fc5e0dcd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -923,6 +923,7 @@ struct amdgpu_device {
>>    	struct amdgpu_irq_src		pageflip_irq;
>>    	struct amdgpu_irq_src		hpd_irq;
>>    	struct amdgpu_irq_src		dmub_trace_irq;
>> +	struct amdgpu_irq_src		dmub_outbox_irq;
>>    
>>    	/* rings */
>>    	u64				fence_context;
>> @@ -1077,6 +1078,7 @@ struct amdgpu_device {
>>    
>>    	bool                            in_pci_err_recovery;
>>    	struct pci_saved_state          *pci_state;
>> +	struct completion dmub_aux_transfer_done;
> 
> Does this completion need to be on the amdgpu device itself?
> 
> I would prefer if we keep this as needed within DM itself if possible.
> 
>>    };
>>    
>>    static inline struct amdgpu_device *drm_to_adev(struct drm_device
>> *ddev) diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
>> b/drivers/gpu/drm/amd/include/amd_shared.h
>> index 43ed6291b2b8..097672cc78a1 100644
>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>> @@ -227,7 +227,8 @@ enum DC_DEBUG_MASK {
>>    	DC_DISABLE_PIPE_SPLIT = 0x1,
>>    	DC_DISABLE_STUTTER = 0x2,
>>    	DC_DISABLE_DSC = 0x4,
>> -	DC_DISABLE_CLOCK_GATING = 0x8
>> +	DC_DISABLE_CLOCK_GATING = 0x8,
>> +	DC_ENABLE_DMUB_AUX = 0x10,
> 
> My problem with still leaving this as DC_ENABLE_DMUB_AUX is we shouldn't require the user to have to flip this on by default later. I think I'd prefer this still as a DISABLE option if we want to leave it for users to debug any potential issues.
> 
> If there's no value in having end users debug issues by setting this bit then we should keep it as a dc->debug default in DCN resource.
> 
> Regards,
> Nicholas Kazlauskas
> 
>>    };
>>    
>>    enum amd_dpm_forced_level;
>> diff --git a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
>> b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
>> index e2bffcae273a..754170a86ea4 100644
>> --- a/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
>> +++ b/drivers/gpu/drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h
>> @@ -1132,5 +1132,7 @@
>>    
>>    #define DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       0x68
>>    #define DCN_1_0__CTXID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT       6
>> +#define DCN_1_0__SRCID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT        0x68 // DMCUB_IHC_outbox1_ready_int IHC_DMCUB_outbox1_ready_int_ack DMCUB_OUTBOX_LOW_PRIORITY_READY_INTERRUPT DISP_INTERRUPT_STATUS_CONTINUE24 Level/Pulse
>> +#define DCN_1_0__CTXID__DMCUB_OUTBOX_LOW_PRIORITY_READY_INT        8
>>    
>>    #endif // __IRQSRCS_DCN_1_0_H__
>>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
