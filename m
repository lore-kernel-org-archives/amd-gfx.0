Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C81C47096
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 14:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F17613AA
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 14:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F17613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F796EA63;
	Thu,  3 Jun 2021 14:00:45 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7E2E6EA63
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 14:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCcQNi+ulaLMhkHAfARmE1oLdL3Hn/UzB65c51XvXFBSilIHFEo6DQvwUqqLwrV75p0D8D4/b32KUiWnqJab0Nk0OJfFs0dhBa/kVAG6wp/aM/qWTk7/+7EuN6zCMkW8LDX0p2d0dWATDdVZZgwNdpO2rydxGjDaY7MIm+FEXSg3DApPgM+x9q4hRMUac8Mq66bWbqSNnBMn/rNNlMjRKsZVgUf5tnFXxo35aU//E5NjaALwLwSaise/2KbdxzWo8sE8S0zArmiAvA1bZRnGUI/dzlvpHq4YG7O5tzAg+m+cDVHnGL2mXWnml15MikYev+MOn69MkZdLyGG7GE6a2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Le5qUOFkwVKablgyTb7mAWLm3bNKxFkDtK6Iz34d8yQ=;
 b=AnedK/69dPPJg5qdkGuoR8GbKC9nH57O1Vx1fmCSlvVm/3mI2h6bGBnZeD007qWAI5UGQRyhfOcPC7UUm+nGCEpPfOOzmqtJApuUC7LMQbsNiwi7IifzLqHh048J2RBbIBShBuKnIBKN8zWEUTGRNWcvJZBZ1VLrleoV11WetId8xE03ESIA2b0+tLgph7rfeeLG1+RT84UrNIh25/yYTmFmN1EaG89ERfrnN9q/3Dh6b3VXzWU2ifBnQNHb66j8OgBQNjoo+W6kFkyhyo0UwaVW2vU0THwRXNus0ZEQKfKKJueH1cUzmocFJ6HNeZwFoNvcWRCtXewEZ68H5Yp0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Le5qUOFkwVKablgyTb7mAWLm3bNKxFkDtK6Iz34d8yQ=;
 b=n3s8sgij1isJx/lfKEYrilcP3e+iz4uxeHCWBqn+Lb94sRSeSmE9UdHis/iwyKiWMcTVejn2Qjy+2Kb2UF1UNhpWwTWs6rI83jvkst9O5xHmLfogcc3iFOOemLFxHr405v/7iC+nOfqO+M/c6gvRasyvFwzJ6eZbc7UTCOrv2dw=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5073.namprd12.prod.outlook.com (2603:10b6:610:e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 3 Jun
 2021 14:00:41 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 14:00:41 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
Thread-Topic: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
Thread-Index: AQHXVxHnYPEHUtcMDUObTN9iSTFtEasAI9aAgAIhzoCAAAb8kA==
Date: Thu, 3 Jun 2021 14:00:40 +0000
Message-ID: <CH0PR12MB53480D82E2D1C8EF998760F4973C9@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210601181231.24773-1-Graham.Sider@amd.com>
 <20210601181231.24773-4-Graham.Sider@amd.com>
 <DM6PR12MB26199099168565AAFB6690ACE43D9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB30676D0E36B54D85296A685F8A3C9@DM6PR12MB3067.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB30676D0E36B54D85296A685F8A3C9@DM6PR12MB3067.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-03T14:00:31Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1160a2c4-c7ad-40a2-846e-0d6c59d370a7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2401:4900:2352:158d:f03b:a89b:f8c1:18e4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33574eb7-de67-43db-b1f0-08d92697f933
x-ms-traffictypediagnostic: CH0PR12MB5073:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB507393686672A31777A768A4973C9@CH0PR12MB5073.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: smbDe3VW9tGVUUZidt3MySqj1x5GrgRbcxybPGx0+llljERdUICEdrdcmr0TduziYimewcaPAQ1GIvnsLv+KNal2FBMRLEjmGxLI7W1ARIov99lMMtt7TdaDcRH2+/FLyTGGUn5xVjTW5c+94+WiTD/I3FEqtzp3XFoB7bCrUHqYmu63reZstzWB3QFF7HQuS5lzBzdCc88U2GXuat1rCvGrELifACBOn+Ch7z6V7YXm/bh+AlZmA/hFgGgRdKFBmzu1z6czJD8NChR/p/5jV5IiSK64iasXfglWmgKBvj5XyhgHv5N1DneV6GdCYhnacp3SwQxkEz4Z4N83b3MtfpuXMygyHLmpMLs2fqafSwFFu5A6IIWCXLQaziVmJfMFFlBig1P6y+Rlu5KYH4bqohIUtbv0T2SUwlYLR9wLzxPN51I4Pc3mBXC41Xagg4LHcAFggZBj97xlHFUD2vQP0RgFINooUSSOueBtLpcpCbWVOJjktjAGCk110pR0+biPew/nADzr3i+mrVyalKvISmh/W5iiJHbDukRN9esmWCfZ3aF/tsooFKtUisDsilSwXxQfMx8KFzrSbiIBm8RoZmynA3IS/eUgtcFpVyJguplBgfrqs9qVR/pBrpROxMuJzgwcTcLCasMbU4v+znIE8e3Nl06xyGpPXyVvRBCi0Z9iPzd29F0alx3fw8TJyxhurAMqG7qar0M7gD4wBEfKkV0g8v90B685qg7pWifL0B/bdOx14eLkA37y76i5+XPuRBqt4xthrYS8QJ8z6Npp58LZtzibl0dGVNCr4LD/O+4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(33656002)(38100700002)(4326008)(966005)(122000001)(9686003)(45080400002)(55016002)(8936002)(478600001)(186003)(2906002)(52536014)(316002)(83380400001)(71200400001)(53546011)(7696005)(86362001)(54906003)(66446008)(64756008)(66556008)(66476007)(66946007)(8676002)(6506007)(76116006)(110136005)(5660300002)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?N/Y55t/+DCWq5E7zpVrhfMFGCeTVgyor23FsJXsXW7GZhmYHDnRFoDr+rKTo?=
 =?us-ascii?Q?7vJ/So9KbKgZpBZVmoEEsqyd+gD0N6CmK4hNCmMtNvHCzAsDSLUh+2ySaW3b?=
 =?us-ascii?Q?Ype9rVVfkWX50l8n/7h7giY60fDg3gfSj6sCnQtXZgrNIw4lQzXPQxjGRqdy?=
 =?us-ascii?Q?ojhI+OJtcBH5xq8zETZZqlHSsgrl7+goEbGkt10Li6sfdsgUtWdataX5NAhk?=
 =?us-ascii?Q?UXhVpQkRC2qAUQWFTf0lyj6I1uqlSNTw0q2vIu3XwVDXBcUIL5t7r2PPO7vB?=
 =?us-ascii?Q?ex/TfnLhwH9TrFghCbnA/I19khvqtz1c2VXClWTaYGWTjcVMyuowV4wcStwY?=
 =?us-ascii?Q?oXTBvUptkW7Bmt8vptQ9GT2SNinhhQehDxAZcWYTo61Wi/X5t63uFn5HMR08?=
 =?us-ascii?Q?20BY0VEMtBVYODrmzxX1ZBaCwEGosKfPuJD8FjxvuMAVq9RjVy6P0okIwKyT?=
 =?us-ascii?Q?vBP7E2l6wid/OXrMMClEyUJDjk8VVzDMdKAX9pf6hAo/uaiU3VXt3p4gMss/?=
 =?us-ascii?Q?8NWcMWJKRmcOidRlK8W9K2HqSlPmGH2VDzyy9sssDQjsR/e3cgOzByVjzNYR?=
 =?us-ascii?Q?dOsnYDQ4gughOUozP7Rm45VNyaNRb51lVFSL+9yuQmh3gP78bL7hzjhohDEv?=
 =?us-ascii?Q?K+Q4V2HOnI2IZ8XP//9XOZNaUsx5scdWKGqIXG/9kHqOx9JoNXwfbbo5qezA?=
 =?us-ascii?Q?2b7sW+gzJtX0G7mCHIpzfCAh5jabriv4hqxfSKoJTKGP/Tj/kPvUjPwfDBLo?=
 =?us-ascii?Q?ZjQhxGat+HSnSAlXailEBXiatStEuZ4z5bEaQDZjHoGakm2zYyfJ/wlq0H++?=
 =?us-ascii?Q?GgEKKf4iq0xiH7VjSRJF0IWDOjRTtKr1qK1G5AMKcwW2mOhAcBsxupRy6WoI?=
 =?us-ascii?Q?3XNS4w4+KLyYvSG4bRWDjVrtT/0lQllPIRJ/qJZO8QRa4E6VKK/7xpmoA4Tg?=
 =?us-ascii?Q?FfUi6aq2zJLf+doyJRU+gCu5VPArMpSzusTsMcZub5Oar1MHGBz5ynv9YB7h?=
 =?us-ascii?Q?VK8cwdzG3MFc6zo4T4UhknbNgS4hcDSbVWXgT81YIYvxn1vo9SyT6UXK/hSQ?=
 =?us-ascii?Q?OPhotLT0Cytgwuc0vLVSjjVGCVF3iGdOr2VfHbTmHm4fu9r6HpjuC0m2gRkq?=
 =?us-ascii?Q?WhmTJTFQ/VXFzMqt+esJi5A6ZB1LoCGUBr1lsCaE31moAKZcOxhQmRbA7akd?=
 =?us-ascii?Q?g/LKew5zJytqvLUgSwmx/T8WVf75VwZWkbVmT3zbvCnA82+5GET6R/Vfput9?=
 =?us-ascii?Q?C9as5f/iQS91PSXyCRzBqfnlgm+vVEAFdhRmWFjlFeuc7fM0t3jI+jhtcYjN?=
 =?us-ascii?Q?22Gegsc//FCuyCr7mdF/yY3YKJToL5jhVdXd2Ynu9Fft082KPgJf6Bw2op1k?=
 =?us-ascii?Q?AL89GYmDONcOgn7QYlQudIkipuEs?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33574eb7-de67-43db-b1f0-08d92697f933
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 14:00:41.0785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSREuEPrXBoQ8ztam857ghp9sd21NzLVyY02FfQ2rm9I8qxhHKwV4LBROZUqpSBG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Sakhnovitch, 
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

VR_*0/1 reflect the throttle status of separate voltage rails - availability of both depends on board and FW capability to query their temperature.

Thanks,
Lijo

-----Original Message-----
From: Sider, Graham <Graham.Sider@amd.com> 
Sent: Thursday, June 3, 2021 6:41 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation

Some ASICs use a single VR_MEM bit, whereas others split it into VR_MEM0 and VR_MEM1. To avoid confusion, we've combined the VR_MEM0 and VR_MEM1 bits on those ASICs. For consistency we did the same with LIQUID0 and LIQUID1. 

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Wednesday, June 2, 2021 12:37 AM
To: Sider, Graham <Graham.Sider@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sider, Graham <Graham.Sider@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation

[AMD Official Use Only]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
> Graham Sider
> Sent: Wednesday, June 2, 2021 2:12 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kasiviswanathan, Harish 
> <Harish.Kasiviswanathan@amd.com>; Sider, Graham 
> <Graham.Sider@amd.com>; Sakhnovitch, Elena (Elen) 
> <Elena.Sakhnovitch@amd.com>
> Subject: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
> 
> Perform dependent to independent throttle status translation for 
> navi1x. Makes use of lookup table navi1x_throttler_map.
> 
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43
> +++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 78fe13183e8b..bf376b1be08d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -238,6 +238,28 @@ static struct cmn2asic_mapping 
> navi10_workload_map[PP_SMC_POWER_PROFILE_COUNT] =
>  	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
> 	WORKLOAD_PPLIB_CUSTOM_BIT),
>  };
> 
> +static const uint8_t navi1x_throttler_map[] = {
> +	[THROTTLER_TEMP_EDGE_BIT]	=
> (SMU_THROTTLER_TEMP_EDGE_BIT),
> +	[THROTTLER_TEMP_HOTSPOT_BIT]	=
> (SMU_THROTTLER_TEMP_HOTSPOT_BIT),
> +	[THROTTLER_TEMP_MEM_BIT]	=
> (SMU_THROTTLER_TEMP_MEM_BIT),
> +	[THROTTLER_TEMP_VR_GFX_BIT]	=
> (SMU_THROTTLER_TEMP_VR_GFX_BIT),
> +	[THROTTLER_TEMP_VR_MEM0_BIT]	=
> (SMU_THROTTLER_TEMP_VR_MEM_BIT),
> +	[THROTTLER_TEMP_VR_MEM1_BIT]	=
> (SMU_THROTTLER_TEMP_VR_MEM_BIT),
[Quan, Evan] I'm wondering why you map the two ASIC dependent bits to the same non ASIC independent bit. Instead of defining two non ASIC independent bits.
> +	[THROTTLER_TEMP_VR_SOC_BIT]	=
> (SMU_THROTTLER_TEMP_VR_SOC_BIT),
> +	[THROTTLER_TEMP_LIQUID0_BIT]	=
> (SMU_THROTTLER_TEMP_LIQUID_BIT),
> +	[THROTTLER_TEMP_LIQUID1_BIT]	=
> (SMU_THROTTLER_TEMP_LIQUID_BIT),
[Quan, Evan] Same question here and for Patch4.

BR
Evan
> +	[THROTTLER_TDC_GFX_BIT]		=
> (SMU_THROTTLER_TDC_GFX_BIT),
> +	[THROTTLER_TDC_SOC_BIT]		=
> (SMU_THROTTLER_TDC_SOC_BIT),
> +	[THROTTLER_PPT0_BIT]		=
> (SMU_THROTTLER_PPT0_BIT),
> +	[THROTTLER_PPT1_BIT]		=
> (SMU_THROTTLER_PPT1_BIT),
> +	[THROTTLER_PPT2_BIT]		=
> (SMU_THROTTLER_PPT2_BIT),
> +	[THROTTLER_PPT3_BIT]		=
> (SMU_THROTTLER_PPT3_BIT),
> +	[THROTTLER_FIT_BIT]		= (SMU_THROTTLER_FIT_BIT),
> +	[THROTTLER_PPM_BIT]		=
> (SMU_THROTTLER_PPM_BIT),
> +	[THROTTLER_APCC_BIT]		=
> (SMU_THROTTLER_APCC_BIT),
> +};
> +
> +
>  static bool is_asic_secure(struct smu_context *smu)  {
>  	struct amdgpu_device *adev = smu->adev; @@ -524,6 +546,19 @@ static 
> int navi10_tables_init(struct smu_context
> *smu)
>  	return -ENOMEM;
>  }
> 
> +static uint64_t navi1x_get_indep_throttler_status(
> +					const unsigned long dep_status)
> +{
> +	uint64_t indep_status = 0;
> +	uint8_t dep_bit = 0;
> +
> +	for_each_set_bit(dep_bit, &dep_status, 32)
> +		indep_status |= smu_u64_throttler_bit(dep_status,
> +			navi1x_throttler_map[dep_bit], dep_bit);
> +
> +	return indep_status;
> +}
> +
>  static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
>  					      MetricsMember_t member,
>  					      uint32_t *value)
> @@ -2673,6 +2708,8 @@ static ssize_t
> navi10_get_legacy_gpu_metrics(struct smu_context *smu,
>  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> 
>  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +
> 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> 
>  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> 
> @@ -2750,6 +2787,8 @@ static ssize_t navi10_get_gpu_metrics(struct 
> smu_context *smu,
>  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> 
>  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +
> 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> 
>  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> 
> @@ -2826,6 +2865,8 @@ static ssize_t
> navi12_get_legacy_gpu_metrics(struct smu_context *smu,
>  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> 
>  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +
> 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> 
>  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> 
> @@ -2908,6 +2949,8 @@ static ssize_t navi12_get_gpu_metrics(struct 
> smu_context *smu,
>  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> 
>  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +
> 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> 
>  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> 
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cf05ba28afbe0417ac
> 54008d925290dc0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> 7581680520671680%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
> PzZzTHlRh0ygXIJdQeN8%2Ff4ojC9KcCy4Ia5POPGw1nI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
