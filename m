Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1015C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 13:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACCD23A53
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 13:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACCD23A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3264B6E92B;
	Tue,  8 Dec 2020 13:39:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF9C86E92B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 13:39:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXQAknSZlQpChuBBArsVcoOi3atUSB7Jf5tFAozxz14f2B0eeztCZorNxUrznAw6ZsAFSpNUiADnqFy81uXKyRNYgCId2c3QuEDsEc7UDLeFvi1qba/GAc65g+V7y7MKfJD1uIw7rWJzaNU25gXIZ1BxtbJTrvd6snmTtdX/WG4dT0OYUH9DBhqcmuhzxEHDai8kxI8bcpP6BwyFg9subqJ76uNJwVy2goDQxFAlB4sf0gai1G32o0xd6CfDreAnBbw9lol9G57ABiyA7sMmdu4ZDTZWJNhiycDaFXeBgla+yQ1vMx5yJouC4x3usSKBWRxegm/eeOybfu+RmSAEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVNW8Mm0+zV0dajeQPFJiODHHKE7xlpZSe/Y6yPdxk4=;
 b=cTPXZFwLPe1bgvSwqortkDgiZsMx3DwdwCe1GuYoD8+A1u4wVBtnKqyMM9UP6qmXwZlm27kOoJ1D/SuMe2knkwNwGDxIWFmIe/KlmzWpNhPoOALshS5t3d4iLe9+HsHrwX/kD9nP0AldqjGDggrBj7FmGeUyzCD6Wi1aKWEdo8gkdxYj+VzuxWLbhSL54GWHD2Tf7zsjr7GIEL/uBzfWOYoqeuu8zL11kcS+GPju8Doqd0RPsftiWf958QnxIht/pzM6CumBnh0CyE6pXHLJ0zJpM3LFOMpk89fCMFdGKlX+oTo3skYyrpgJmPW3Crm1Wb8Q4hUJ2vSMc9Oo8fVqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVNW8Mm0+zV0dajeQPFJiODHHKE7xlpZSe/Y6yPdxk4=;
 b=AqZ0AfIc5ndfvjdesmYDHhAuYk8RV7kV9V02PCMofJYd9wH4FhVYK/HJh1LHtNPzIqkJwy7+5NqJLUIpODIB6JfhiQr1oMdRhq3ETMHLdAl6PRJJbBicxIK3OCOf1or39IHUmEAOLX2aSvNEL1tSQI382IaT3jkSSFl84NWUzOE=
Received: from BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 by MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 8 Dec
 2020 13:39:19 +0000
Received: from BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05]) by BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05%2]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 13:39:19 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "Hou, Xiaomeng (Matthew)"
 <Xiaomeng.Hou@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu/pm: inform PMFW rlc status before
 start/stop rlc for vangogh
Thread-Topic: [PATCH 3/3] drm/amdgpu/pm: inform PMFW rlc status before
 start/stop rlc for vangogh
Thread-Index: AQHWzVQtFKe9tGFJUUCVnV+azPhQkantK96AgAAEyiA=
Date: Tue, 8 Dec 2020 13:39:18 +0000
Message-ID: <BL0PR12MB4913E8D83717DDD2B23DAAF997CD0@BL0PR12MB4913.namprd12.prod.outlook.com>
References: <20201208111942.6292-1-Xiaomeng.Hou@amd.com>
 <20201208111942.6292-3-Xiaomeng.Hou@amd.com> <20201208130847.GD661395@hr-amd>
In-Reply-To: <20201208130847.GD661395@hr-amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-08T13:39:15Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a34e640e-c6e0-4c12-a69b-0000bce5df3c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-08T13:39:09Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ed0b9422-fb7a-45ad-8c9c-0000b43ae44b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-08T13:39:16Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ba0aa811-d084-4a80-b26a-000047d322f4
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.216.168]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9aa0cc61-e738-4249-681a-08d89b7ea9d5
x-ms-traffictypediagnostic: MN2PR12MB4549:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4549F74919B8216FA5AAB66E97CD0@MN2PR12MB4549.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SId/12sNshWgODxWnvsXt+4jTvgqmw+uB41mN9LWcL9Wk8aaIEHshuqAvQ7dK7qarVUDbAtllatGQGFT9Do3GNYAGFwvP5lOsDc7oEy168jng2kJC7bZAJfgnNG7qtsNTr2wuT1G7u8RMUrXO67ekIHGK1JoR2wNmfKYG7hdg+oNouDBvAZzFiup9lDpZ2cGFWscrLx7CxL0u20TQ21hX8qbUYwo17QeTtvJ+UPa2psAW8X1OSprPRLXNzwK4jt/FBZpXNZiD7UHHBPXpt9pvVnsUmAnjMdfYRWvA8rJOW+c6F6IuX4qoZskhYSyP3dyPZkrzosRqe2ytfVkHuNMqlaq6nZE8uOiJuIGjpK0ToU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4913.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(52536014)(316002)(186003)(26005)(8936002)(55236004)(6506007)(66556008)(64756008)(966005)(7696005)(76116006)(54906003)(9686003)(66476007)(66946007)(55016002)(86362001)(66446008)(5660300002)(6636002)(2906002)(8676002)(71200400001)(4326008)(83380400001)(53546011)(478600001)(45080400002)(33656002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FE9Wvy0yPN8jjl9t71gwzEuQVwef2SGVfCVQhaoUjKD5z13ti4lg/JpZxt7N?=
 =?us-ascii?Q?eS6zJMCTG79yV9mLk11HgtUpdLUprNS6S7NdaTtRls28WRNFu+uHqfWApRaU?=
 =?us-ascii?Q?LQPP3TXWxIljbit4YeDPx/O4BAT1huRGWNdWOl1WImHuVIGop0JIXHlvapOf?=
 =?us-ascii?Q?9vYDN2NYmFGvmJF35OoPXG8w11n0uS1Kve5H57LEjKChaayQ+M+Rus1Qr16D?=
 =?us-ascii?Q?ETZ7CPwUwbFCccQizamdKG0lWp/lWaovm5KA/N+n6LWQhyFD67Fz8b0kTyxN?=
 =?us-ascii?Q?syJ+yiO5nbudr2zW/dg3bYKfa+DlWnnI/tkwCz4TUtQuzVeI7E2Uh3zrvNtg?=
 =?us-ascii?Q?2qcgWIE1PMCTci6BhrzfwIFtY/sSUTglo4ok6YQpPjoAiuHvM7XTejOHIS1z?=
 =?us-ascii?Q?CFb0yRXO6TXen3wypeO1IrI7uWF1COB4ghtnB2dgyBH+OmHkJgZYRA6NIdZs?=
 =?us-ascii?Q?vkM33iEor8MXE9iRyRZRCf1fZ8kUzoBFFTRlz3XiElji6vtYmO/AWvSh79a9?=
 =?us-ascii?Q?mkKcAO7cDVZSttKfCn95zneWOtyKU142l9Wbn5zTP+01/i7QYkVIwXBIAmMt?=
 =?us-ascii?Q?9rclAyT2AdoQZdZo2ZjZI57hbGRsp8StGJQ05IXXE13bYzXPrYO9PVbvDOM/?=
 =?us-ascii?Q?CkWJXUxwxPtpgSkHoFl2wJeokuV/SY1USsuCB6v3BeTiHN3KZm73AQ8Z2b6H?=
 =?us-ascii?Q?rSkYQj4iki9ICwLxnxVMIQ8HRnGN8tDO/wj0FvuZCdWDQv6b64GtsfYTmHn8?=
 =?us-ascii?Q?uGfVP+HlO8rKSk7idbaomMchyYSg+JG87S4iM+9tfKveAXkPA5IYS8VRKDdV?=
 =?us-ascii?Q?pPUfm2k03Nhma4b4FH6OE7sl8HfM078m9JKr//YpS6zPWg4mWvc6KTJWuVEI?=
 =?us-ascii?Q?eX0KVFAHQT4PpAQkZjo+3QFHUXGQOGAYLK+i+hj9RpCRPaOeRVOeesmceMFI?=
 =?us-ascii?Q?5Z6h3hq26RVDgS3pk4kZHnS+tTLrspuehQVOVfsRalA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4913.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa0cc61-e738-4249-681a-08d89b7ea9d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 13:39:18.9479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fmnx9PHvI5H5mDQhHviEuFFVGQUjgmVQaM5Z9uCWN+FhHbw0RHFmhIpJz6h0AXI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4549
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

> You can create two new callbacks in ppt_funcs->inform_rlc(smu, on), and set on as bool type

We can't keep adding ASIC specific workarounds as ppt_funcs. We should make use of the existing ones or have something generic to handle these quirks. System features control is one generic place in the logic which is used to control features. It's used in dGPU context only now, but it may be repurposed for FW notifications.

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang Rui
Sent: Tuesday, December 8, 2020 6:39 PM
To: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/amdgpu/pm: inform PMFW rlc status before start/stop rlc for vangogh

[CAUTION: External Email]

On Tue, Dec 08, 2020 at 07:19:42PM +0800, Hou, Xiaomeng (Matthew) wrote:
> RLC is halted when system suspend/shutdown. However, due to DPM 
> enabled, PMFM is unaware of RLC being halted and will continue sending 
> messages, which would eventually caused ACPI related hang. So send 
> message to inform PMFM the rlc status before start/stop rlc.
>
> Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
> Change-Id: I7b1a04f6e249ac6753109079ecb3019c99161d9f
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c 
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index cf999b7a2164..42a32c0e5bab 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -920,6 +920,14 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>       uint32_t pcie_gen = 0, pcie_width = 0;
>       int ret = 0;
>
> +     if (adev->in_suspend && smu->is_apu) {
> +             ret = smu_notify_rlc_status(smu, 1);

You can create two new callbacks in ppt_funcs->inform_rlc(smu, on), and set on as bool type.

Then you can use below macros to implement this callback with RLC notify SMC message.

/* RLC Power Status */
#define RLC_STATUS_OFF          0
#define RLC_STATUS_NORMAL       1

Others look good for me.

Thanks,
Ray

> +             if (ret) {
> +                     dev_info(adev->dev, "Failed to notify rlc status!\n");
> +                     return ret;
> +             }
> +     }
> +
>       if (adev->in_suspend && smu_is_dpm_running(smu)) {
>               dev_info(adev->dev, "dpm has been enabled\n");
>               /* this is needed specifically */ @@ -1213,6 +1221,14 @@ 
> static int smu_disable_dpms(struct smu_context *smu)
>                       dev_err(adev->dev, "Failed to disable smu features.\n");
>       }
>
> +     if (smu->is_apu) {
> +             ret = smu_notify_rlc_status(smu, 0);
> +             if (ret) {
> +                     dev_info(adev->dev, "Failed to notify rlc status!\n");
> +                     return ret;
> +             }
> +     }
> +
>       if (adev->asic_type >= CHIP_NAVI10 &&
>           adev->gfx.rlc.funcs->stop)
>               adev->gfx.rlc.funcs->stop(adev);
> --
> 2.17.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C346c5521a1e848a40efe08d89b7a6ca7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637430297401242320%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=6t589ueoS0x26%2FdpzSdtQmjkRygo4ez11t0GuBMacyg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
