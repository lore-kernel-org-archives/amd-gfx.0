Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD5CC38A2A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 20:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7568620643
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 20:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qVkNASRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7568620643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DE7D6EA65;
	Thu,  7 May 2020 20:47:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C6416EA65
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 20:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHhO+9bjhPLV4u6dG2EAzOBeFIj/w8ndeiMnVARcSr0g647Ym4jY2PtpQbzV2JnZd5Fi8eUQX0tJmlwopi6K9rQvw/QtUeBThPQN+PYkceoQ7sfbq/Aeog93C0YhGRoxFwUZb2f99Y5nslfDThLgQ6bnHhDCfYrpQRoSc5qU1XwD3hG1etyC0f4qDCqUtzWDQdALpK9/59W1YyzbfpKTUUexro5RWRqD0JMOm34FStjcAtDSOMV6Q5nCs+NyA+4ve17eFd/WegJm6ssOS+6DKHAgyn60dX8G9BSaSI53ZDrDtyMW5sGHnuYTEFaJmjkUt5+s0O/k251qky2zdscB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2C1d71Y0S9myLUPlo2DJLXvCpC4orblVeEPyeLjgpw=;
 b=h0rjJgiqdZdMwlpZ5FYPpIRQKBgfAumSXmcOBH0I0rBHAYIWjDkeGWMieEJy7cqj6kgERvBbxyySwxnZmSH70H8dlKWfbsMvJNKNltu7pfxOA8QLIRCS+CTpTw0S4bV7ahzDa3VkSmSXLyQ5pCdbsTOt/7zwbAA0Wk3OZxCy0J8puviOBS/jYg2Go9qcwwWCF+BEAMEYCRESG9QzizeqpO/9xmIu0gkijG1DKnUytf8ALTe76QmboDsRvydqRN5fGgxySPlK9M0lURcr+2aGCw8119VqMFT2E6irp1qkvQDrq5YSzXfiXhrbzX9FQNWU9d9Aa7GwKRH8PFftYxazqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2C1d71Y0S9myLUPlo2DJLXvCpC4orblVeEPyeLjgpw=;
 b=qVkNASRGlfyy0RbMXWgI89lAZ44V09m+LD1FPG4pZ9cTnGqGpSlPh7mwpk4GBJdViTDwhbzioFXCh5KwxkF4p1sIZavfHSHGwCXCoDJqNr6MeLSjZzTqQfbkXeXn4h4WlAKp6mJ9SBtlF4dRaAhCrDV69o7ASwc9/9XTXKaPReE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB3232.namprd12.prod.outlook.com (2603:10b6:208:ab::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 20:47:05 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::c578:193b:bda9:ac5c]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::c578:193b:bda9:ac5c%7]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 20:47:04 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: cleanup sysfs file handling
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200507201449.4453-1-nirmoy.das@amd.com>
 <CADnq5_OcPP96BxCFqAo9kXYomONXgZU1t6pHXvTGDTLs7beWOA@mail.gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <99cc8de9-dc05-1693-b901-d5b98936c4be@amd.com>
Date: Thu, 7 May 2020 21:46:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <CADnq5_OcPP96BxCFqAo9kXYomONXgZU1t6pHXvTGDTLs7beWOA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::14) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f24:c300:bc9a:61db:99e9:7465]
 (2003:c5:8f24:c300:bc9a:61db:99e9:7465) by
 FR2P281CA0027.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.31 via Frontend Transport; Thu, 7 May 2020 20:47:00 +0000
X-Originating-IP: [2003:c5:8f24:c300:bc9a:61db:99e9:7465]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 891139b2-c8bf-4f1b-1b16-08d7f2c7cccc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3232:|MN2PR12MB3232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32326379B99855F7634416818BA50@MN2PR12MB3232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Oz4wZzCRYvG1P1dqc4sGISL++Q667GrjA0iN4oUHvoPFgBHIfb0WxT5PXI11ez73w9KN57aHKS/2cIYGpbZOUDlw2VudLIbhhJ0yqPfivyteuzjrdUN45Gqp1SySp+YcIlyWIxrpMaYRee2TO1hvD1Swh56ckpN48jy98vU9TzksZrz0Pa/gEtUbaOWDK+ZcU1KYV/9UTPzjZf5eJu5dY6EvnyOCpzxRIJkehyVS2L4TeU5GCBuN9U40AmvhQKucC2TCn11ohgmiWcCMm+3dNqm94RMbFCwoTTLVWkHJccvlgISomW9lK6cu0Cxs8O5VCFl/4J2ob5kNe+s/zFAEu6gvQxPiF9PKsbYqw89EZ0n1fo7Sy+Ilq51Sv6AF+lQcd65z94XHY5vRdEiHIOBxXoZsaZSBkN4YHh878PN6aEiCJ3dlHZUemzNdfhlM+A3OZk1QFrOuhY055e2ZJKSwkbVG4UmjImI/sGDqYicWnHiiWAfupHfwmh9DZcj3Ord+SItjKGkuibJzDcGIfl8WrjVyGfwLBvTTBZ7T/QiZ2n9JUZDVmzhmRONYKPDkO9NCSEhwQuuFcnMQWVJpEaC1H39AdV/Dzd1F3YqlvM18zk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(33430700001)(186003)(478600001)(6486002)(36756003)(31696002)(86362001)(8936002)(6916009)(4326008)(31686004)(8676002)(52116002)(316002)(66946007)(33440700001)(66476007)(45080400002)(2906002)(6666004)(16526019)(5660300002)(83320400001)(83280400001)(83310400001)(83290400001)(66556008)(83300400001)(54906003)(966005)(53546011)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UVAB9HRJTbn/U1to0/9hPSL0C215yVuZsdTDhMdmywhjD4zFmhLbIw4ABO9nowgfu6CKSc6hFtUjJS5F7t5xPa3uq3YWMMzpfuExbecaMTvPVX0DMW6GEIdVLNn5rfdA8biweAV/ijHQwlWUXwSGq0GLXgvrUKXUa3jxe5MdYwSlKJhZuLInjJUpfj6R8vnfL7iha9GZFRWxXF0im7wb5YIn8MBOGQVcoe5pwAXL821vXkixF5wFnZXlcZbPxkNLb0sal5tkH/QtBWC38dnYepDRQzf/2hP+3D514r8OH2mW20clDIahvY0v2Q/t6ebUxCBmigbFie5KIE88DN1dwGtKwICxs4CFizYB/BJTjL43vpq3N/SWJz1Xze5WjM7LxJBfgtankwZU+8YIjO2rYQrOUv4Liv5bt72eteR8MvIOKspC3vXTK/R58WyrTBIOqMwDEk3FuDdmQDkXK00w5jW4OiVF8PRqPd+Vn4g/TntoGHLf6eu9PQ77lTkHrhBaHEp6dI3XVVRT1qnVbYcMEMgoVjf77l41/3j9YVeZtrh6qq94r6twAKXywrZpvXgXytkIGpBG6VpVjv4hrjaSinphWbaFFdcNVEB43Etp7luZaqjRyoImwRn55uGaFUb9865fa12iW4+fSnkxz/u3xA++k006OWABNNqnACRo5gdgePChCav07ZGQDAAQMTxUm9misbdqJ/8i9Kxux8T0wk2AX98RafekH1o3LWQ0ASnd/ZbNU9Pqc4McYQdKaU6YOfzJFIcdjyuE1A9myZ+dVY6owWHDH1mw8WZYr2AjYCFGkuId/Tnl+up423knD/H3cLXx5EiPmjUjwK7nDGsxdANgA1PRGd7okJZv/YHtb40=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891139b2-c8bf-4f1b-1b16-08d7f2c7cccc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:47:04.7654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfCcRsC8rZA85lxRtWWiBlE52NgRkG8wRdgrkN+ZEvxvJLm2getpTwaePRIBvn+I9c73xFhAhx7H5FhWyEpstw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3232
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 5/7/2020 9:21 PM, Alex Deucher wrote:
> On Thu, May 7, 2020 at 4:15 PM Nirmoy Das <nirmoy.das@amd.com> wrote:
>> Create sysfs file using attributes when possible.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  36 +++----
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> for the amdgpu_device.c changes.  For amdgpu_pm.c, I think Kevin has a
> patch set out to clean this up as well that also fixes up the VF
> handling.  May want to check with him on the pm changes.


Thanks Alex, I didn't know. I will check with Kevin.


Regards,

Nirmoy

>
> Alex
>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c     | 114 +++++++--------------
>>   2 files changed, 48 insertions(+), 102 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index bf302c799832..cc41e8f5ad14 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2918,6 +2918,14 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>>          return ret;
>>   }
>>
>> +static const struct attribute *amdgpu_dev_attributes[] = {
>> +       &dev_attr_product_name.attr,
>> +       &dev_attr_product_number.attr,
>> +       &dev_attr_serial_number.attr,
>> +       &dev_attr_pcie_replay_count.attr,
>> +       NULL
>> +};
>> +
>>   /**
>>    * amdgpu_device_init - initialize the driver
>>    *
>> @@ -3267,27 +3275,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>          queue_delayed_work(system_wq, &adev->delayed_init_work,
>>                             msecs_to_jiffies(AMDGPU_RESUME_MS));
>>
>> -       r = device_create_file(adev->dev, &dev_attr_pcie_replay_count);
>> -       if (r) {
>> -               dev_err(adev->dev, "Could not create pcie_replay_count");
>> -               return r;
>> -       }
>> -
>> -       r = device_create_file(adev->dev, &dev_attr_product_name);
>> +       r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
>>          if (r) {
>> -               dev_err(adev->dev, "Could not create product_name");
>> -               return r;
>> -       }
>> -
>> -       r = device_create_file(adev->dev, &dev_attr_product_number);
>> -       if (r) {
>> -               dev_err(adev->dev, "Could not create product_number");
>> -               return r;
>> -       }
>> -
>> -       r = device_create_file(adev->dev, &dev_attr_serial_number);
>> -       if (r) {
>> -               dev_err(adev->dev, "Could not create serial_number");
>> +               dev_err(adev->dev, "Could not create amdgpu device attr\n");
>>                  return r;
>>          }
>>
>> @@ -3370,12 +3360,10 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>>          adev->rmmio = NULL;
>>          amdgpu_device_doorbell_fini(adev);
>>
>> -       device_remove_file(adev->dev, &dev_attr_pcie_replay_count);
>>          if (adev->ucode_sysfs_en)
>>                  amdgpu_ucode_sysfs_fini(adev);
>> -       device_remove_file(adev->dev, &dev_attr_product_name);
>> -       device_remove_file(adev->dev, &dev_attr_product_number);
>> -       device_remove_file(adev->dev, &dev_attr_serial_number);
>> +
>> +       sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>>          if (IS_ENABLED(CONFIG_PERF_EVENTS))
>>                  amdgpu_pmu_fini(adev);
>>          if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>> index c762deb5abc7..f375bc341acc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>> @@ -3239,6 +3239,27 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_versio
>>          return 0;
>>   }
>>
>> +static const struct attribute *amdgpu_pm_attributes[] = {
>> +       &dev_attr_power_dpm_state.attr,
>> +       &dev_attr_power_dpm_force_performance_level.attr,
>> +       &dev_attr_pp_dpm_sclk.attr,
>> +       &dev_attr_pp_dpm_mclk.attr,
>> +
>> +       &dev_attr_pp_sclk_od.attr,
>> +       &dev_attr_pp_mclk_od.attr,
>> +       &dev_attr_pp_power_profile_mode.attr,
>> +       &dev_attr_gpu_busy_percent.attr,
>> +       NULL
>> +};
>> +
>> +static const struct attribute *amdgpu_pm_non_vf_attributes[] = {
>> +       &dev_attr_pp_num_states.attr,
>> +       &dev_attr_pp_cur_state.attr,
>> +       &dev_attr_pp_force_state.attr,
>> +       &dev_attr_pp_table.attr,
>> +       NULL
>> +};
>> +
>>   int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>>   {
>>          struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
>> @@ -3260,45 +3281,6 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>>                  return ret;
>>          }
>>
>> -       ret = device_create_file(adev->dev, &dev_attr_power_dpm_state);
>> -       if (ret) {
>> -               DRM_ERROR("failed to create device file for dpm state\n");
>> -               return ret;
>> -       }
>> -       ret = device_create_file(adev->dev, &dev_attr_power_dpm_force_performance_level);
>> -       if (ret) {
>> -               DRM_ERROR("failed to create device file for dpm state\n");
>> -               return ret;
>> -       }
>> -
>> -       if (!amdgpu_sriov_vf(adev)) {
>> -               ret = device_create_file(adev->dev, &dev_attr_pp_num_states);
>> -               if (ret) {
>> -                       DRM_ERROR("failed to create device file pp_num_states\n");
>> -                       return ret;
>> -               }
>> -               ret = device_create_file(adev->dev, &dev_attr_pp_cur_state);
>> -               if (ret) {
>> -                       DRM_ERROR("failed to create device file pp_cur_state\n");
>> -                       return ret;
>> -               }
>> -               ret = device_create_file(adev->dev, &dev_attr_pp_force_state);
>> -               if (ret) {
>> -                       DRM_ERROR("failed to create device file pp_force_state\n");
>> -                       return ret;
>> -               }
>> -               ret = device_create_file(adev->dev, &dev_attr_pp_table);
>> -               if (ret) {
>> -                       DRM_ERROR("failed to create device file pp_table\n");
>> -                       return ret;
>> -               }
>> -       }
>> -
>> -       ret = device_create_file(adev->dev, &dev_attr_pp_dpm_sclk);
>> -       if (ret) {
>> -               DRM_ERROR("failed to create device file pp_dpm_sclk\n");
>> -               return ret;
>> -       }
>>
>>          /* Arcturus does not support standalone mclk/socclk/fclk level setting */
>>          if (adev->asic_type == CHIP_ARCTURUS) {
>> @@ -3312,11 +3294,20 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>>                  dev_attr_pp_dpm_fclk.store = NULL;
>>          }
>>
>> -       ret = device_create_file(adev->dev, &dev_attr_pp_dpm_mclk);
>> +       ret = sysfs_create_files(&adev->dev->kobj, amdgpu_pm_attributes);
>>          if (ret) {
>> -               DRM_ERROR("failed to create device file pp_dpm_mclk\n");
>> +               DRM_ERROR("failed to create pm sysfs files\n");
>>                  return ret;
>>          }
>> +
>> +       if (!amdgpu_sriov_vf(adev)) {
>> +               ret = sysfs_create_files(&adev->dev->kobj, amdgpu_pm_non_vf_attributes);
>> +               if (ret) {
>> +                       DRM_ERROR("failed to create pm sysfs files\n");
>> +                       return ret;
>> +               }
>> +       }
>> +
>>          if (adev->asic_type >= CHIP_VEGA10) {
>>                  ret = device_create_file(adev->dev, &dev_attr_pp_dpm_socclk);
>>                  if (ret) {
>> @@ -3352,23 +3343,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>>                          return ret;
>>                  }
>>          }
>> -       ret = device_create_file(adev->dev, &dev_attr_pp_sclk_od);
>> -       if (ret) {
>> -               DRM_ERROR("failed to create device file pp_sclk_od\n");
>> -               return ret;
>> -       }
>> -       ret = device_create_file(adev->dev, &dev_attr_pp_mclk_od);
>> -       if (ret) {
>> -               DRM_ERROR("failed to create device file pp_mclk_od\n");
>> -               return ret;
>> -       }
>> -       ret = device_create_file(adev->dev,
>> -                       &dev_attr_pp_power_profile_mode);
>> -       if (ret) {
>> -               DRM_ERROR("failed to create device file "
>> -                               "pp_power_profile_mode\n");
>> -               return ret;
>> -       }
>> +
>>          if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
>>              (!is_support_sw_smu(adev) && hwmgr->od_enabled)) {
>>                  ret = device_create_file(adev->dev,
>> @@ -3379,13 +3354,6 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>>                          return ret;
>>                  }
>>          }
>> -       ret = device_create_file(adev->dev,
>> -                       &dev_attr_gpu_busy_percent);
>> -       if (ret) {
>> -               DRM_ERROR("failed to create device file "
>> -                               "gpu_busy_level\n");
>> -               return ret;
>> -       }
>>          /* APU does not have its own dedicated memory */
>>          if (!(adev->flags & AMD_IS_APU) &&
>>               (adev->asic_type != CHIP_VEGA10)) {
>> @@ -3437,16 +3405,11 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
>>
>>          if (adev->pm.int_hwmon_dev)
>>                  hwmon_device_unregister(adev->pm.int_hwmon_dev);
>> -       device_remove_file(adev->dev, &dev_attr_power_dpm_state);
>> -       device_remove_file(adev->dev, &dev_attr_power_dpm_force_performance_level);
>>
>> -       device_remove_file(adev->dev, &dev_attr_pp_num_states);
>> -       device_remove_file(adev->dev, &dev_attr_pp_cur_state);
>> -       device_remove_file(adev->dev, &dev_attr_pp_force_state);
>> -       device_remove_file(adev->dev, &dev_attr_pp_table);
>> +       sysfs_remove_files(&adev->dev->kobj, amdgpu_pm_attributes);
>> +       if (!amdgpu_sriov_vf(adev))
>> +               sysfs_remove_files(&adev->dev->kobj, amdgpu_pm_non_vf_attributes);
>>
>> -       device_remove_file(adev->dev, &dev_attr_pp_dpm_sclk);
>> -       device_remove_file(adev->dev, &dev_attr_pp_dpm_mclk);
>>          if (adev->asic_type >= CHIP_VEGA10) {
>>                  device_remove_file(adev->dev, &dev_attr_pp_dpm_socclk);
>>                  if (adev->asic_type != CHIP_ARCTURUS)
>> @@ -3456,15 +3419,10 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
>>                  device_remove_file(adev->dev, &dev_attr_pp_dpm_pcie);
>>          if (adev->asic_type >= CHIP_VEGA20)
>>                  device_remove_file(adev->dev, &dev_attr_pp_dpm_fclk);
>> -       device_remove_file(adev->dev, &dev_attr_pp_sclk_od);
>> -       device_remove_file(adev->dev, &dev_attr_pp_mclk_od);
>> -       device_remove_file(adev->dev,
>> -                       &dev_attr_pp_power_profile_mode);
>>          if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
>>              (!is_support_sw_smu(adev) && hwmgr->od_enabled))
>>                  device_remove_file(adev->dev,
>>                                  &dev_attr_pp_od_clk_voltage);
>> -       device_remove_file(adev->dev, &dev_attr_gpu_busy_percent);
>>          if (!(adev->flags & AMD_IS_APU) &&
>>               (adev->asic_type != CHIP_VEGA10))
>>                  device_remove_file(adev->dev, &dev_attr_mem_busy_percent);
>> --
>> 2.26.2
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cnirmoy.das%40amd.com%7C7347df60ad514491ffb908d7f2c4383b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637244796884676621&amp;sdata=XjTrg30N9ifFJ79Ykl08OqhgIXGfZi6WxmZiFEgebJE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
