Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E458DC33CB6
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 19:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E512082F
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 19:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kPMd8aAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E512082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BFDE6F8D1;
	Fri, 17 Jan 2020 19:29:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 917DD6F8D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 19:29:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzbpNOoHjZ3KUPJBWzL9ZC05DPVAPDAYizAb4ulhNaBQTU7ZqUTJOnL7TpHMPNpUPQ3wqj/rz8Ld2FbfMkRtsbIzX7Y+2bvNYXAi520nmK7WQvsslwHhzl+Zy8QdnzCL6XboVhIvvFMquSE8F9AH8b9gEVkKIa7l7kJnKXUt3RkM1jOGt1FlDQ/zjxJBK6COh/FeTn/VI/uSXG7+Tn/mZd6Hr+RLGu8EScuqWx5OF/csco7M90IFrjp8oK8krqJAUGmKATxfZ8mg4bynbQa4QD7Aov/fVoODl9nqW/RjZxFJ556bYftcdMNQwVYcd/V4h6Mqme1F55sJUsOaryldzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdZUO244R1SmlleLccMmL+0Z8wwG5AC47outKmz7ZM8=;
 b=odJYTzQXC6TdZC3msm0IOhz8ynyVWrdvA/VnIGS1hk7ASlritMuIoDkdzE6JVuNNkz0w7MO2WTgqyBYaNckcUH8xLLPC5HNdQ2bRAw8eYpdiJJ48KjZOzSJJog2P3pptjS/9HROPqumEZXhgs5xDY0nCKvwzbh78KMXdNQoEo6KdXZy3hSSsYJQ23zyeUqyvpgROdd6p4ubqNVeywWmIY3kpAu9sFSYQnrFB7Q/u3EU+N21ZwIfiBINkps6egTdB+aWm5PB2YObODlc+pQ3Z0Htg74kubzNQmhJYq5fPCAGnwIlkia7Ibl4IzMWncMtJwUMemqd/3HEK0lvMfIHCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdZUO244R1SmlleLccMmL+0Z8wwG5AC47outKmz7ZM8=;
 b=kPMd8aAfpPJgS4Fn62ZIHVjBkZFxs594NVQ/oolKDpF8oHnFKg+t3WxJKK01O4UWwVa0jXFfitKqMHBIK2tW+fUnj+0NpSLT5SkqZiyBCCq5Qne3mGSuOn713Fvbis/NWHJy0xHwnGdT6T+SXyH+32bF/6Z5gsjVvMqhpgiZISc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Bhawanpreet.Lakha@amd.com; 
Received: from DM6PR12MB4236.namprd12.prod.outlook.com (10.141.184.142) by
 DM6PR12MB3273.namprd12.prod.outlook.com (20.179.106.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Fri, 17 Jan 2020 19:29:44 +0000
Received: from DM6PR12MB4236.namprd12.prod.outlook.com
 ([fe80::91ac:1f2d:b4ca:c0a4]) by DM6PR12MB4236.namprd12.prod.outlook.com
 ([fe80::91ac:1f2d:b4ca:c0a4%6]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 19:29:44 +0000
Subject: Re: [PATCH 3/5] drm/amd/display: Add sysfs interface for set/get srm
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
 <20200116202945.21801-4-Bhawanpreet.Lakha@amd.com>
 <CADnq5_Ms88BpiKvk5Okitu944yd3Ar5=AAzDb-_ne-SFP7YAEw@mail.gmail.com>
From: Bhawanpreet Lakha <Bhawanpreet.lakha@amd.com>
Message-ID: <bc556236-d047-6de6-5d73-09cf7f3278af@amd.com>
Date: Fri, 17 Jan 2020 14:29:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <CADnq5_Ms88BpiKvk5Okitu944yd3Ar5=AAzDb-_ne-SFP7YAEw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::22) To DM6PR12MB4236.namprd12.prod.outlook.com
 (2603:10b6:5:212::14)
MIME-Version: 1.0
Received: from [172.29.2.119] (165.204.55.250) by
 YTXPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Fri, 17 Jan 2020 19:29:43 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93fe56cb-6ab6-4c4d-471f-08d79b839afd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3273:|DM6PR12MB3273:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32731C9B6CFE4AF1DE96CA9EF9310@DM6PR12MB3273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0285201563
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(199004)(189003)(316002)(16576012)(54906003)(956004)(31686004)(2616005)(81156014)(53546011)(81166006)(52116002)(8676002)(66946007)(66556008)(66476007)(31696002)(6486002)(45080400002)(26005)(36756003)(478600001)(86362001)(2906002)(5660300002)(186003)(8936002)(4326008)(6916009)(16526019)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3273;
 H:DM6PR12MB4236.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNPTZFzOHoiJ1V8yPvWUggIiVI7KMPu4i/fKo0yvAveiaxWPJEkJQ3wIyLtSqqQWSwh11tcg5HtENVlCcSGc+aAEK3+cMnC+fojB6yazMQQ0ALZe/HSyn3Xa3GOZNA8ib1fT9e5NNnAggoFg8waN6mp6V53ii9S/WT9KnTHjzXQuJR/4F4ZC4Dwme1A2HbrzkEswQ3JpDAYz0Vs0yC5a6gnDJm5/rEKHUy0bUdxmCjOrDpgdqN+1TlSjxSHGBB5eYcHgDzfzg+heS6hWq9wW+45ekdtNe9DanW3Is/H4Lb39sfOXW/2aVkhyHZDzKjKqUy/7aMDfqrvjAukSKTPCYamKqHTas089NCf4ecu6Uf5wDNVjT1MoMj2+NiU1vCnMHFxj/RLTKEelrc+TB/iN3SedPF34ii04k+N28NZ5Giz+4rOQoGFq8kTlkeDsQjBEBngoL26VW2+GdpG71HFnki1STv37Bgqi/T4XBg01MEA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fe56cb-6ab6-4c4d-471f-08d79b839afd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 19:29:44.0481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTu7UZ0nfCQGaCPDcI2EBPTwu9T5EGXrsxgg+gkJhqB5E3Os2ORya2H0LbC9pE26
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3273
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
Cc: "Wentland, Harry" <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-01-17 2:23 p.m., Alex Deucher wrote:
> On Thu, Jan 16, 2020 at 3:30 PM Bhawanpreet Lakha
> <Bhawanpreet.Lakha@amd.com> wrote:
>> [Why]
>> We need to set/get SRM and linux kernel is not suppose to write to the
>> storage, so we need to provide a interface.
>>
>> [How]
>> Provide interface so usermode can set/get srm
>>
>> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
>> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> ---
>>   .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 124 +++++++++++++++++-
>>   .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   6 +
>>   2 files changed, 128 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
>> index a269916f7dd6..a191c84ad8eb 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
>> @@ -28,6 +28,8 @@
>>   #include "amdgpu_dm.h"
>>   #include "dm_helpers.h"
>>   #include <drm/drm_hdcp.h>
>> +#include "hdcp_psp.h"
>> +
>>
>>   static bool
>>   lp_write_i2c(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
>> @@ -67,6 +69,16 @@ lp_read_dpcd(void *handle, uint32_t address, uint8_t *data, uint32_t size)
>>          return dm_helpers_dp_read_dpcd(link->ctx, link, address, data, size);
>>   }
>>
>> +static uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size)
>> +{
>> +       return NULL;
>> +}
>> +
>> +static int psp_set_srm(struct psp_context *psp, uint8_t *srm, uint32_t srm_size, uint32_t *srm_version)
>> +{
>> +       return 0;
>> +}
>> +
>>   static void process_output(struct hdcp_workqueue *hdcp_work)
>>   {
>>          struct mod_hdcp_output output = hdcp_work->output;
>> @@ -88,6 +100,18 @@ static void process_output(struct hdcp_workqueue *hdcp_work)
>>          schedule_delayed_work(&hdcp_work->property_validate_dwork, msecs_to_jiffies(0));
>>   }
>>
>> +static void link_lock(struct hdcp_workqueue *work, bool lock)
>> +{
>> +
>> +       int i = 0;
>> +
>> +       for (i = 0; i < work->max_link; i++) {
>> +               if (lock)
>> +                       mutex_lock(&work[i].mutex);
>> +               else
>> +                       mutex_unlock(&work[i].mutex);
>> +       }
>> +}
>>   void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
>>                           unsigned int link_index,
>>                           struct amdgpu_dm_connector *aconnector,
>> @@ -302,7 +326,8 @@ void hdcp_destroy(struct hdcp_workqueue *hdcp_work)
>>          }
>>
>>          kfree(hdcp_work);
>> -
>> +       kfree(hdcp_work->srm);
>> +       kfree(hdcp_work->srm_temp);
>>   }
>>
>>   static void update_config(void *handle, struct cp_psp_stream_config *config)
>> @@ -338,6 +363,84 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
>>          hdcp_update_display(hdcp_work, link_index, aconnector, DRM_MODE_HDCP_CONTENT_TYPE0, false);
>>   }
>>
>> +
>> +/*
>> + * This can be called twice, because SRM_SIZE > PAGE_SIZE.
>> + *
>> + * We set the SRM on each call, if SRM_SIZE > PAGE_SIZE, PSP will fail on the
>> + * first call but pass on the second call.
>> + *
>> + * Because of this we are not throwing any errors as it will stop the next call.
>> + * So it is a good idea to call the "read" sysfs to verify that the SRM was set
>> + *
>> + */
> Rather than using a file to get the data directly in chunks, how about
> adding a sysfs file where you can specify the path to the srm file.
> The driver can then use the path provided to call request firmware and
> just get the entire binary in one shot.
>
> Alex
>
>
I thought about using request_firmware but, since we also need to save 
the data aswell

and there is no "save_firmware" interface, we would have difference 
interfaces for reading and writing.

So to keep it consistent I used sysfs for both. Now we just cat and echo 
the raw data. vs echo file patch and cat raw data.


Bhawan

>> +static ssize_t srm_data_write(struct file *filp, struct kobject *kobj, struct bin_attribute *bin_attr, char *buffer,
>> +                             loff_t pos, size_t count)
>> +{
>> +       struct hdcp_workqueue *work;
>> +       uint32_t srm_version = 0;
>> +
>> +       work = container_of(bin_attr, struct hdcp_workqueue, attr);
>> +       link_lock(work, true);
>> +
>> +       memcpy(work->srm_temp + pos, buffer, count);
>> +
>> +       if (!psp_set_srm(work->hdcp.config.psp.handle, work->srm_temp, pos + count, &srm_version)) {
>> +               DRM_DEBUG_DRIVER("HDCP SRM SET version 0x%X", srm_version);
>> +               memcpy(work->srm, work->srm_temp, pos + count);
>> +               work->srm_size = pos + count;
>> +               work->srm_version = srm_version;
>> +       }
>> +
>> +
>> +       link_lock(work, false);
>> +
>> +       return count;
>> +}
>> +
>> +static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin_attribute *bin_attr, char *buffer,
>> +                            loff_t pos, size_t count)
>> +{
>> +       struct hdcp_workqueue *work;
>> +       uint8_t *srm = NULL;
>> +       uint32_t srm_version;
>> +       uint32_t srm_size;
>> +       size_t ret = count;
>> +
>> +       work = container_of(bin_attr, struct hdcp_workqueue, attr);
>> +
>> +       link_lock(work, true);
>> +
>> +       srm = psp_get_srm(work->hdcp.config.psp.handle, &srm_version, &srm_size);
>> +
>> +       if (!srm)
>> +               return -EINVAL;
>> +
>> +       if (pos >= srm_size)
>> +               ret = 0;
>> +
>> +       if (srm_size - pos < count) {
>> +               memcpy(buffer, srm + pos, srm_size - pos);
>> +               ret = srm_size - pos;
>> +               goto ret;
>> +       }
>> +
>> +       memcpy(buffer, srm + pos, count);
>> +
>> +ret:
>> +       link_lock(work, false);
>> +       return ret;
>> +}
>> +
>> +
>> +static const struct bin_attribute data_attr = {
>> +       .attr = {.name = "hdcp_srm", .mode = 0664},
>> +       .size = PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, /* Limit SRM size */
>> +       .write = srm_data_write,
>> +       .read = srm_data_read,
>> +};
>> +
>> +
>>   struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct cp_psp *cp_psp, struct dc *dc)
>>   {
>>
>> @@ -348,10 +451,19 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
>>          if (hdcp_work == NULL)
>>                  goto fail_alloc_context;
>>
>> +       hdcp_work->srm = kcalloc(PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, sizeof(*hdcp_work->srm), GFP_KERNEL);
>> +
>> +       if (hdcp_work->srm == NULL)
>> +               goto fail_alloc_context;
>> +
>> +       hdcp_work->srm_temp = kcalloc(PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, sizeof(*hdcp_work->srm_temp), GFP_KERNEL);
>> +
>> +       if (hdcp_work->srm_temp == NULL)
>> +               goto fail_alloc_context;
>> +
>>          hdcp_work->max_link = max_caps;
>>
>>          for (i = 0; i < max_caps; i++) {
>> -
>>                  mutex_init(&hdcp_work[i].mutex);
>>
>>                  INIT_WORK(&hdcp_work[i].cpirq_work, event_cpirq);
>> @@ -371,10 +483,18 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
>>          cp_psp->funcs.update_stream_config = update_config;
>>          cp_psp->handle = hdcp_work;
>>
>> +       /* File created at /sys/class/drm/card0/device/hdcp_srm*/
>> +       hdcp_work[0].attr = data_attr;
>> +
>> +       if (sysfs_create_bin_file(&adev->dev->kobj, &hdcp_work[0].attr))
>> +               DRM_WARN("Failed to create device file hdcp_srm");
>> +
>>          return hdcp_work;
>>
>>   fail_alloc_context:
>>          kfree(hdcp_work);
>> +       kfree(hdcp_work->srm);
>> +       kfree(hdcp_work->srm_temp);
>>
>>          return NULL;
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
>> index 331b50825510..5159b3a5e5b0 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
>> @@ -53,6 +53,12 @@ struct hdcp_workqueue {
>>
>>          enum mod_hdcp_encryption_status encryption_status;
>>          uint8_t max_link;
>> +
>> +       uint8_t *srm;
>> +       uint8_t *srm_temp;
>> +       uint32_t srm_version;
>> +       uint32_t srm_size;
>> +       struct bin_attribute attr;
>>   };
>>
>>   void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CBhawanpreet.Lakha%40amd.com%7C31850cb2894b4459b6cf08d79b82b6af%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637148858026280913&amp;sdata=%2BncbIbzgws%2BKPbTAqzARNGAZWM66UoxzjDeJm6vvXlg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
