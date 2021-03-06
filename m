Return-Path: <SRS0=7qc2=IE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FB3C433DB
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 21:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4769564FCC
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 21:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4769564FCC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C936E54C;
	Sat,  6 Mar 2021 21:11:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB4046E54C
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Mar 2021 21:11:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESTHWR9f9D8X052b1lwIAGpPUS+lpSkf+BdxBMLmfeZc0tEQe3h2eyhZmkQ1Z+YXuG9cik/asqNH0eA5yOsYsWCAOJIyz675egGi+YJgxeW7qMS49JX2mAsx2Sy3+KSnH2O9Uv3EQC37fl7x7jwJzq/8LX+aeOzWnJpiP7LkP8p9W4kMBorExU0c+424XOCmP6Oi13WddrXaPtwIrf7dYa2IySrnwmMvFMyrS23gGj+0k+F/ptUoS/BEGkw2WwBYOMVFeal9lyXXDhfB2vDaTZIEM1z4f8yaEKvk8lDhdNCOJH5mpDeuVDSRqQ1b/L3s9HLGmWoETKFkXRhjq6BpEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRRkGphsV/Dx4pG+xX7Rger6Cka6Yx519vu0hkRq+9g=;
 b=fQys8cLy7buWRX6ALRgVJlrgrPSCumiNVR1LKAX4Av4YxRgIY17tGQ4OwQ4vYlXqqnc9+tA6hI+RJvaF9XjL0SzY+gD2gYmM3yt3af/yQr2/GbWcNiwvlrz7uNiKnxZuiMwPG9pVlixb5mHsFtlp+bFs7ZqYsrhM5sLofiBKIpktZ42IrcFs2l1jGrwmUg/P+QUVFdafgh/plY0ej2iJui+askrNeHPPx3S0ReTlhpCrRlESe3WjfLIZY2MZYyvyfeTtn7cuBKKhDPFGzg0+35sDsT95NtVe2g4103p4hB6xYfyNl3O8o/vutWjmG7UI0c/o6q9vUZgRWUS2ieHEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRRkGphsV/Dx4pG+xX7Rger6Cka6Yx519vu0hkRq+9g=;
 b=b1NQbxVCGsRt5sEmjL/3Dd93ooThGk3MJhR1PemiY1UDBzlNayyeofhu3V3OsNBAFidVKh5J5phrkPifjdB5WDrYANeBH0FFjZLhr8QX7r52fmZesn3QNWjZSf2KPk952WaHnfWYxfPJ7pGT9I48k7q/juKvT+MV1qA/K9WJYeM=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR12MB1755.namprd12.prod.outlook.com (2603:10b6:3:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Sat, 6 Mar
 2021 21:11:19 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.025; Sat, 6 Mar 2021
 21:11:19 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Grodzovsky, Andrey"
 <Andrey.Grodzovsky@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
Thread-Topic: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive
 duirng probe
Thread-Index: AQHXEehnkJi0ZBdQLUmnTOEKi9nTFKp1xzgAgABa9PCAAFhyAIAA8H4ggAAJLuA=
Date: Sat, 6 Mar 2021 21:11:19 +0000
Message-ID: <DM6PR12MB3835340976F1AB36BA768D4FF4959@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210305175257.32219-1-shaoyun.liu@amd.com>
 <34643514-c054-242a-336e-1ac9ab7ffcc7@amd.com>
 <DM6PR12MB3835CA23C6EA827DE36FC1A1F4959@DM6PR12MB3835.namprd12.prod.outlook.com>
 <69c471aa-3a68-6a54-608f-c03c73c0b248@amd.com>
 <DM6PR12MB3835E7CD4FAC9CFCE33549FCF4959@DM6PR12MB3835.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3835E7CD4FAC9CFCE33549FCF4959@DM6PR12MB3835.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-06T21:11:14Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6e202096-a04e-46ba-871b-9a968b50193e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d7b14c8-2ba8-4fdd-97da-08d8e0e46373
x-ms-traffictypediagnostic: DM5PR12MB1755:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1755316B1111A9B5EC14BC66F4959@DM5PR12MB1755.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xnw/+R7pXIkx7Wc1GBLb8R+9JPO2kK2P7uOZl1cUySQEW/IIaPuBNCrIH/47OFb1P+CY3YouNXLNMnZdJsgMM0KfuREz0UryrnW4Q7vd0soIDRY0/4/6P8Hgp4vnDFtLklLJ/GRSl0RF4xztDvwjGysbT/Mn8Lj8rAb4YSQ2CbLDUkHpjiZQlT5jAgFCXuyeERxbBr8+pyQVN4Y6KYOtuYsdBI98cn4WO/okoQlscCCJNL4MXsn3/yEn6qm5yful6MtU7j8GQgXg21jEYpFIpgWLs+N3EW26iU1wr6Ia6H46qt7z1b3f5yfFuIBOP3jxyO881LZ6nkMtO0wm8XHXiqBE0YXYLuxfY9pcJMzhA2LZlXaYp5IWkBeWuoZE1pHklQ3gpvq9SRcQAg4Bf+s6cup/bj2mv6mKgYVtyei+k9SmD0neJxTu6mXEGfFZcuBzP7R/uvlYFjXkaic4ZkK247jFrVPogKrpiVwyasqM8Elr+gGFee5Ys2icY/qexjYWQI7S3efUqJiSO/Xp5iowxbArc3MMNlqQcqrC/QLKMLh5RhaxuPdKwepvhjHVz5+3SvHDIQzoVXVNhWeQ5LW0wDkLrqcvwZv2waNf9AxLPnY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(66946007)(71200400001)(86362001)(66556008)(66476007)(66446008)(64756008)(7696005)(2940100002)(8936002)(478600001)(45080400002)(76116006)(53546011)(33656002)(966005)(8676002)(6506007)(55016002)(26005)(83380400001)(186003)(2906002)(5660300002)(30864003)(9686003)(316002)(110136005)(52536014)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DG6NAWbIffKAhhlXqfO1oFsHrPHv9hVAgtB9oX2WpiGgrwGGFj5oflEvo9mZ?=
 =?us-ascii?Q?kNeqh4szMZPNgI22xn04U9N0/GxltLogMPqfznjIte3aCb73J+vemduWT3yO?=
 =?us-ascii?Q?UZw/mCXaKJOSvAFUCpoHQuWeH2kcv6DXsWFC97dP2ivdkZZrB8kN6xd6tOCo?=
 =?us-ascii?Q?n27+NtJMigaHeb5nvIRXvO2Vti0mD3vS8sWDupNtEmn8dHzqCInox7ISpaBn?=
 =?us-ascii?Q?Lhpnrq8G0jQGDTa3cmauX/wy8DQm4vjAggMttt175mWP54mRLZaG14r0Xd8A?=
 =?us-ascii?Q?Kn3pLIGpuMDG7ifUgmUEmoC794IFLVH1AJuXguPdb+dTY5K9RWoGf8SKOOME?=
 =?us-ascii?Q?bRj6aWogYc59OAgp41AMsPOzhUA2fZB9pyfnf0UFZd7o5MVlHbZZ1IxdhKky?=
 =?us-ascii?Q?bZRLfgpUmWPROf5yslGbE7BvunKBbZ+nfIHnZs7tq1FagypyE/+lSK1x9AFZ?=
 =?us-ascii?Q?y5C70D0Rzwkoc+OyAU77IPQP6PpmDbF+lxUUQ+PSWuhDmt8I2D061tqJN+hh?=
 =?us-ascii?Q?n0dofOAv8x99mOD/w/10bX/tFjxUCgJxoh3lb6KeRpXNQe7ufgp5rSYXXw3g?=
 =?us-ascii?Q?WKbazukkzdKqkKpUNy0FdWrKKed+nOfGiCZXxQfLV3IiqarMsLWSFUexgiHj?=
 =?us-ascii?Q?oeuxgdIRqFkvNjW0YhQV55PTsMZSJ5DZwF6dRS19LL+BcJns3iBMy4laYulG?=
 =?us-ascii?Q?PbG+BpX7lc1wPhFGkXO+60qzsRClqssgDV4XMfLYOqYzGfA5bb+UPVWEaHSY?=
 =?us-ascii?Q?d9jqnwpXA0MN5Ye23sEYiudkr4TyaR6R7T631JtSlHonoANSUcZY+0QevFlL?=
 =?us-ascii?Q?7NjkLTR/Fs09eVQ4WnYJln60O4yLtnTPAxkpL5EmK6S4McxqR5fdvr7ZUrZj?=
 =?us-ascii?Q?P4jA9lCDvMbwmfvXgHSiBshI9ddZ50IHHGVjHhzkGgywhTxmEzQtpnGbCiO3?=
 =?us-ascii?Q?35M2DTElLAJxeeXNCWq21DD4oB8otIf5MwmwAnauo74LOoJPOazcwub1z6I6?=
 =?us-ascii?Q?5gZuXxFbbruW3YXv+DewDplcRXVR1+SyBNfW+xs2zlvM4mv1wREy+gNnetAZ?=
 =?us-ascii?Q?fH8wyIN5B0dMguUx2ZA65Wk+Jb+SjiQrIE6S2TeaN/wlpSYeswe0FQ0QdB5W?=
 =?us-ascii?Q?Fi+5DlRtg/6MYcDaXDTfruHGDNxr/9w/w3ivmP/toBeSfCj4zoDh3vV7Jgjj?=
 =?us-ascii?Q?vUPxzqXXm9uuT3+DDPHdsGKeU+2Rv3vEDc8bQsYJp13beklsRX76GsCryke0?=
 =?us-ascii?Q?m6Y0TEmxGHEZqgDHJw1dell2/dmnz6Bao8tLt5o8jajjc8T44wfgdL/Ik97a?=
 =?us-ascii?Q?/iqMM8Cl/MW/+jangoezP+fZ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7b14c8-2ba8-4fdd-97da-08d8e0e46373
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2021 21:11:19.7581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQAPCs4IRmqdDwbPm9q4Zfb0JbtA2yLrk9K6nGGhuJD2uc9L8tPL8yEK3SAIy75fov36wUp7QNKnvk125Gbu/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1755
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

It  seems I can  not directly reuse the reset HW  function inside the  amdgpu_do_asic_reset,  the  synchronization is based on hive->tb,   but as explained , we actually don't know the GPU belongs to which hive and will rebuild the correct hive info inside the amdgpu_do_asic_reset function with amdgpu_xgmi_add_device .  so I need to remove  all GPUs from the hive first . This will lead to the sync don't work since the hive->tb will be removed as well when all GPUs are removed . 

Thanks 
shaopyunliu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, Shaoyun
Sent: Saturday, March 6, 2021 3:41 PM
To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng probe

[AMD Official Use Only - Internal Distribution Only]

I call the amdgpu_do_asic_reset with the parameter skip_hw_reset = true  so the reset won't be execute twice .  but probably I can  set this parameter to true and remove the code schedule for reset since now I already build the device_list not based on hive. Let me try that . 
For the  schedule delayed work thread with AMDGPU_RESUME_MS, It's actually not wait for SMU  to start. As I explained , I need to reset the all the GPUs in the system since I don't know which gpus belongs to which hive.  So this time is allow system to probe all the GPUs  in the system which means when this delayed thread starts ,  we can assume all the devices already been  populated in mgpu_info.

Regards
Shaoyun.liu

-----Original Message-----
From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
Sent: Saturday, March 6, 2021 1:09 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng probe

Thanks for explaining this, one thing I still don't understand is why you schedule the reset work explicilty in the begining of amdgpu_drv_delayed_reset_work_handler and then also call amdgpu_do_asic_reset which will do the same thing too. It looks like the physical reset will execute twice for each device.
Another thing is, more like improvement suggestion  - currently you schedule delayed_reset_work using AMDGPU_RESUME_MS - so i guesss this should give enough time for SMU to start ? Is there maybe a way to instead poll for SMU start completion and then execute this - some SMU status registers maybe ? Just to avoid relying on this arbitrary value.

Andrey

On 2021-03-05 8:37 p.m., Liu, Shaoyun wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> Hi,  Andrey
> The existing reset function (amdgpu_device_gpu_recover or amd do_asic _reset) assumed driver already have  the correct hive info . But in my case, it's  not true . The gpus are in a bad state and the XGMI TA  might not functional properly , so driver can  not  get the hive and node info when probe the device .  It means driver even don't know  the device belongs to which hive on a system with multiple hive configuration (ex, 8 gpus in  two hive). The only solution I can think of is let driver trigger the reset on all gpus at the same time after driver do the minimum initialization on the HW ( bring up the  SMU IP)  no matter they belongs to the same hive or not and call amdgpu_xgmi_add_device for each device after re-init .
> The 100 ms delay added after the baco reset . I think they can be removed . let me verify it.
> 
> Regards
> Shaoyun.liu
> 
> 
> 
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Friday, March 5, 2021 2:27 PM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI 
> hive duirng probe
> 
> 
> 
> On 2021-03-05 12:52 p.m., shaoyunl wrote:
>> In passthrough configuration, hypervisior will trigger the 
>> SBR(Secondary bus reset) to the devices without sync to each other.
>> This could cause device hang since for XGMI configuration, all the 
>> devices within the hive need to be reset at a limit time slot. This 
>> serial of patches try to solve this issue by co-operate with new SMU 
>> which will only do minimum house keeping to response the SBR request 
>> but don't do the real reset job and leave it to driver. Driver need 
>> to do the whole sw init and minimum HW init to bring up the SMU and 
>> trigger the reset(possibly BACO) on all the ASICs at the same time
>>
>> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
>> Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  13 +++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 102 +++++++++++++++------
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  71 ++++++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |   1 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |   8 +-
>>    5 files changed, 165 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index d46d3794699e..5602c6edee97 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -125,6 +125,10 @@ struct amdgpu_mgpu_info
>>    	uint32_t			num_gpu;
>>    	uint32_t			num_dgpu;
>>    	uint32_t			num_apu;
>> +
>> +	/* delayed reset_func for XGMI configuration if necessary */
>> +	struct delayed_work		delayed_reset_work;
>> +	bool				pending_reset;
>>    };
>>    
>>    #define AMDGPU_MAX_TIMEOUT_PARAM_LENGTH	256
>> @@ -1124,6 +1128,15 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
>>    bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
>>    bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
>>    
>> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>> +				  struct amdgpu_job *job,
>> +				  bool *need_full_reset_arg);
>> +
>> +int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>> +			  struct list_head *device_list_handle,
>> +			  bool *need_full_reset_arg,
>> +			  bool skip_hw_reset);
>> +
>>    int emu_soc_asic_init(struct amdgpu_device *adev);
>>    
>>    /*
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 3c35b0c1e710..5b520f70e660 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1220,6 +1220,10 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>>    		}
>>    	}
>>    
>> +	/* Don't post if we need to reset whole hive on init */
>> +	if (adev->gmc.xgmi.pending_reset)
>> +		return false;
>> +
>>    	if (adev->has_hw_reset) {
>>    		adev->has_hw_reset = false;
>>    		return true;
>> @@ -2149,6 +2153,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>>    			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
>>    				continue;
>>    
>> +			if (!adev->ip_blocks[i].status.sw)
>> +				continue;
>> +
>>    			/* no need to do the fw loading again if already done*/
>>    			if (adev->ip_blocks[i].status.hw == true)
>>    				break;
>> @@ -2289,7 +2296,10 @@ static int amdgpu_device_ip_init(struct 
>> amdgpu_device *adev)
>>    
>>    	if (adev->gmc.xgmi.num_physical_nodes > 1)
>>    		amdgpu_xgmi_add_device(adev);
>> -	amdgpu_amdkfd_device_init(adev);
>> +
>> +	/* Don't init kfd if whole hive need to be reset during init */
>> +	if (!adev->gmc.xgmi.pending_reset)
>> +		amdgpu_amdkfd_device_init(adev);
>>    
>>    	amdgpu_fru_get_product_info(adev);
>>    
>> @@ -2734,6 +2744,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>>    			adev->ip_blocks[i].status.hw = false;
>>    			continue;
>>    		}
>> +
>> +		/* skip unnecessary suspend if we do not initialize them yet */
>> +		if (adev->gmc.xgmi.pending_reset &&
>> +		    !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
>> +			adev->ip_blocks[i].status.hw = false;
>> +			continue;
>> +		}
>>    		/* XXX handle errors */
>>    		r = adev->ip_blocks[i].version->funcs->suspend(adev);
>>    		/* XXX handle errors */
>> @@ -3407,10 +3427,28 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>    	 *  E.g., driver was not cleanly unloaded previously, etc.
>>    	 */
>>    	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
>> -		r = amdgpu_asic_reset(adev);
>> -		if (r) {
>> -			dev_err(adev->dev, "asic reset on init failed\n");
>> -			goto failed;
>> +		if (adev->gmc.xgmi.num_physical_nodes) {
>> +			dev_info(adev->dev, "Pending hive reset.\n");
>> +			adev->gmc.xgmi.pending_reset = true;
>> +			/* Only need to init necessary block for SMU to handle the reset */
>> +			for (i = 0; i < adev->num_ip_blocks; i++) {
>> +				if (!adev->ip_blocks[i].status.valid)
>> +					continue;
>> +				if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
>> +					DRM_DEBUG("IP %s disabed for hw_init.\n",
>> +						adev->ip_blocks[i].version->funcs->name);
>> +					adev->ip_blocks[i].status.hw = true;
>> +				}
>> +			}
>> +		} else {
>> +			r = amdgpu_asic_reset(adev);
>> +			if (r) {
>> +				dev_err(adev->dev, "asic reset on init failed\n");
>> +				goto failed;
>> +			}
>>    		}
>>    	}
>>    
>> @@ -3541,19 +3579,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>    	/* enable clockgating, etc. after ib tests, etc. since some blocks require
>>    	 * explicit gating rather than handling it automatically.
>>    	 */
>> -	r = amdgpu_device_ip_late_init(adev);
>> -	if (r) {
>> -		dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
>> -		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
>> -		goto failed;
>> +	if (!adev->gmc.xgmi.pending_reset) {
>> +		r = amdgpu_device_ip_late_init(adev);
>> +		if (r) {
>> +			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
>> +			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
>> +			goto failed;
>> +		}
>> +		/* must succeed. */
>> +		amdgpu_ras_resume(adev);
>> +		queue_delayed_work(system_wq, &adev->delayed_init_work,
>> +				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>>    	}
>>    
>> -	/* must succeed. */
>> -	amdgpu_ras_resume(adev);
>> -
>> -	queue_delayed_work(system_wq, &adev->delayed_init_work,
>> -			   msecs_to_jiffies(AMDGPU_RESUME_MS));
>> -
>>    	if (amdgpu_sriov_vf(adev))
>>    		flush_delayed_work(&adev->delayed_init_work);
>>    
>> @@ -3570,6 +3608,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>    	if (amdgpu_device_cache_pci_state(adev->pdev))
>>    		pci_restore_state(pdev);
>>    
>> +	if (adev->gmc.xgmi.pending_reset)
>> +		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
>> +				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>> +
>>    	return 0;
>>    
>>    failed:
>> @@ -4240,14 +4282,16 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>>    }
>>    
>>    
>> -static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>> -					struct amdgpu_job *job,
>> -					bool *need_full_reset_arg)
>> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>> +				  struct amdgpu_job *job,
>> +				  bool *need_full_reset_arg)
>>    {
>>    	int i, r = 0;
>>    	bool need_full_reset  = *need_full_reset_arg;
>>    
>> -	amdgpu_debugfs_wait_dump(adev);
>> +	/* no need to dump if device is not in good state during probe period */
>> +	if (!adev->gmc.xgmi.pending_reset)
>> +		amdgpu_debugfs_wait_dump(adev);
>>    
>>    	if (amdgpu_sriov_vf(adev)) {
>>    		/* stop the data exchange thread */ @@ -4293,10 +4337,10 @@ 
>> static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>    	return r;
>>    }
>>    
>> -static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>> -			       struct list_head *device_list_handle,
>> -			       bool *need_full_reset_arg,
>> -			       bool skip_hw_reset)
>> +int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>> +			  struct list_head *device_list_handle,
>> +			  bool *need_full_reset_arg,
>> +			  bool skip_hw_reset)
>>    {
>>    	struct amdgpu_device *tmp_adev = NULL;
>>    	bool need_full_reset = *need_full_reset_arg, vram_lost = false; 
>> @@
>> -4310,6 +4354,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>    		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>>    			/* For XGMI run all resets in parallel to speed up the process */
>>    			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
>> +				tmp_adev->gmc.xgmi.pending_reset = false;
>>    				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>>    					r = -EALREADY;
>>    			} else
>> @@ -4348,10 +4393,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>    	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>>    		if (need_full_reset) {
>>    			/* post card */
>> -			if (amdgpu_device_asic_init(tmp_adev))
>> +			r = amdgpu_device_asic_init(tmp_adev);
>> +			if (r) {
>>    				dev_warn(tmp_adev->dev, "asic atom init failed!");
>> -
>> -			if (!r) {
>> +			} else {
>>    				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
>>    				r = amdgpu_device_ip_resume_phase1(tmp_adev);
>>    				if (r)
>> @@ -4384,6 +4429,9 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>    				 */
>>    				amdgpu_register_gpu_instance(tmp_adev);
>>    
>> +				if (!hive && tmp_adev->gmc.xgmi.num_physical_nodes > 1)
>> +					amdgpu_xgmi_add_device(tmp_adev);
>> +
>>    				r = amdgpu_device_ip_late_init(tmp_adev);
>>    				if (r)
>>    					goto out;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 253c59e0a100..aebe4bc561ee 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -44,6 +44,7 @@
>>    #include "amdgpu_amdkfd.h"
>>    
>>    #include "amdgpu_ras.h"
>> +#include "amdgpu_xgmi.h"
>>    
>>    /*
>>     * KMS wrapper.
>> @@ -167,8 +168,13 @@ uint amdgpu_freesync_vid_mode;
>>    int amdgpu_reset_method = -1; /* auto */
>>    int amdgpu_num_kcq = -1;
>>    
>> +static void amdgpu_drv_delayed_reset_work_handler(struct work_struct 
>> +*work);
>> +
>>    struct amdgpu_mgpu_info mgpu_info = {
>>    	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
>> +	.delayed_reset_work = __DELAYED_WORK_INITIALIZER(
>> +			mgpu_info.delayed_reset_work,
>> +			amdgpu_drv_delayed_reset_work_handler, 0),
>>    };
>>    int amdgpu_ras_enable = -1;
>>    uint amdgpu_ras_mask = 0xffffffff; @@ -1297,6 +1303,71 @@ 
>> amdgpu_pci_shutdown(struct pci_dev *pdev)
>>    	adev->mp1_state = PP_MP1_STATE_NONE;
>>    }
>>    
>> +/**
>> + * amdgpu_drv_delayed_reset_work_handler - work handler for reset
>> + *
>> + * @work: work_struct.
>> + */
>> +static void amdgpu_drv_delayed_reset_work_handler(struct work_struct
>> +*work) {
>> +	struct list_head device_list;
>> +	struct amdgpu_device *adev;
>> +	int i, r;
>> +	bool need_full_reset = true;
>> +
>> +	mutex_lock(&mgpu_info.mutex);
>> +	if (mgpu_info.pending_reset == true) {
>> +		mutex_unlock(&mgpu_info.mutex);
>> +		return;
>> +	}
>> +	mgpu_info.pending_reset = true;
>> +	mutex_unlock(&mgpu_info.mutex);
>> +
>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>> +		adev = mgpu_info.gpu_ins[i].adev;
>> +		r = amdgpu_device_pre_asic_reset(adev, NULL, &need_full_reset);
> 
> Why amdgpu_device_pre_asic_reset is needed ?
> 
>> +		if (r) {
>> +			dev_err(adev->dev, "GPU pre asic reset failed with err, %d for drm dev, %s ",
>> +				r, adev_to_drm(adev)->unique);
>> +		}
>> +		if (!queue_work(system_unbound_wq, &adev->xgmi_reset_work))
>> +			r = -EALREADY;
> 
> amdgpu_do_asic_reset bellow will already schedule xgmi_reset_work for this device, what you could do instead is call amdgpu_do_asic_reset for each member of the hive and because there is a task barrier in amdgpu_device_xgmi_reset_func, it will synchronize all the resets to same point in time already.
> 
>> +	}
>> +	msleep(100);
> 
> What's the 100ms is wiating for ?
> 
>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>> +		adev = mgpu_info.gpu_ins[i].adev;
>> +		adev->gmc.xgmi.pending_reset = false;
>> +		flush_work(&adev->xgmi_reset_work);
>> +	}
>> +
>> +	msleep(100);
> 
> Same as above
> 
>> +	/* reset function will rebuild the xgmi hive info , clear it now */
>> +	for (i = 0; i < mgpu_info.num_dgpu; i++)
>> +		amdgpu_xgmi_remove_device(mgpu_info.gpu_ins[i].adev);
>> +
>> +	INIT_LIST_HEAD(&device_list);
>> +
>> +	for (i = 0; i < mgpu_info.num_dgpu; i++)
>> +		list_add_tail(&mgpu_info.gpu_ins[i].adev->reset_list,
>> +&device_list);
>> +
>> +	/* unregister the GPU first, reset function will add them back */
>> +	list_for_each_entry(adev, &device_list, reset_list)
>> +		amdgpu_unregister_gpu_instance(adev);
>> +
>> +	r = amdgpu_do_asic_reset(NULL, &device_list, &need_full_reset, true);
>> +	if (r) {
>> +		DRM_ERROR("reinit gpus failure");
>> +		return;
>> +	}
>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>> +		adev = mgpu_info.gpu_ins[i].adev;
>> +		if (!adev->kfd.init_complete)
>> +			amdgpu_amdkfd_device_init(adev);
>> +		amdgpu_ttm_set_buffer_funcs_status(adev, true);
>> +	}
>> +	return;
>> +}
>> +
>>    static int amdgpu_pmops_suspend(struct device *dev)
>>    {
>>    	struct drm_device *drm_dev = dev_get_drvdata(dev); diff --git 
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> index aa0c83776ce0..8c71d84a2fbe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -149,6 +149,7 @@ struct amdgpu_xgmi {
>>    	struct list_head head;
>>    	bool supported;
>>    	struct ras_common_if *ras_if;
>> +	bool pending_reset;
>>    };
>>    
>>    struct amdgpu_gmc {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> index 659b385b27b5..b459ef755ea9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> @@ -492,7 +492,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>>    	if (!adev->gmc.xgmi.supported)
>>    		return 0;
>>    
>> -	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>> +	if (!adev->gmc.xgmi.pending_reset &&
>> +	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>    		ret = psp_xgmi_initialize(&adev->psp);
>>    		if (ret) {
>>    			dev_err(adev->dev,
>> @@ -538,7 +539,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device
>> *adev)
>>    
>>    	task_barrier_add_task(&hive->tb);
>>    
>> -	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>> +	if (!adev->gmc.xgmi.pending_reset &&
>> +	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>    		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
>>    			/* update node list for other device in the hive */
>>    			if (tmp_adev != adev) {
>> @@ -567,7 +569,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>>    		}
>>    	}
>>    
>> -	if (!ret)
>> +	if (!ret && !adev->gmc.xgmi.pending_reset)
>>    		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
>>    
>>    exit_unlock:
>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CShaoyun.Liu%40amd.com%7C73608bda6abd48a3047608d8e0e02e4f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637506600750277165%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=2qASlLYQ08twP0Ud5EcisCsVlJ9WG0QJv5idbuhDe4o%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
