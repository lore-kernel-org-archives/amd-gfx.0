Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B986DC38BFA
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 21:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0F220CC7
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 21:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YwnUbOCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0F220CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C16189933;
	Mon, 24 Feb 2020 21:51:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E35489933
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 21:51:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fe4NRcflVOsRQ17s3IR4Znq2ewcbpnCNm1HB7FdTLvJDJGEmcXjy57ZEgo1UypzqJP92pV49mnd8MYBrzpM2oj69p0N9l2dy5HzIHQ0UUuYXYojeVgXq1muj0ZBqko1LwB03mAsaCOAjSD8frC3YOk0gjrNqv+IUJlM1x74sf0u21rWQMdZBLjIQAXnNpQbVRItn09C56DpatZF9do/bkWYWDC0+ahNfZ/8XLzSyg+kJ2JRL26ymCWGesVyLbsWmv7gJymSq2wwmfrW4MsL13FKVfFhZNB+nCQQkrgMot1fBQpe7VVHuzhqdeWkqIQQR1h3SL4m1eXJTDS0hJZXA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O/6+ZDJc5NWhas2WvFN7f/Db8xrJxVS82slsgxuX2w=;
 b=TM1kVRGK61OyA11oMkLJp6Sk80eIO4gMI3OT456zsh0N2Hvavew/sEpKgAkGnGvmqp0vMQQeBAQaXc0tXepipEdrn5arH0oaFGsXUYbw094JOMItRnbICf17gItBoQYd9RbZu9ZXFiThA2S3LQf7txOAb36HNlL3OX5b8v2rEe1VNypsuRmsiEQSd82iOUudngcdt6JiIXYCnCTnzWvX0ipEy1mNTQnoGmPJ5tm1gpTuMdZSDZg+NW7qxByJp5/ANA017AMGQhn0t4HqIx+M3G4KOs0QSZHh2Z2FX9hI2VOaBUOPWxQrFJbwJOGyIiLMcR4rgtNisp38fBzGeow1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O/6+ZDJc5NWhas2WvFN7f/Db8xrJxVS82slsgxuX2w=;
 b=YwnUbOCppgTMOTTmV3j51sk7W0dX6kXBA7btUNgJWT03zUZJpQHbeZpyx98VGjzBfdB1gvuThpJLkMoJLfVYLujuQtzeluUjFWyDqRTEjA2TOpah/kxR3w9qEEx6dqSNjq1bkEt4Sa6ATvz3pqTFrHw2eAnq/DfZo+9gRTZpmjQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Bhawanpreet.Lakha@amd.com; 
Received: from DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14)
 by DM6PR12MB2906.namprd12.prod.outlook.com (2603:10b6:5:15f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Mon, 24 Feb
 2020 21:51:50 +0000
Received: from DM6PR12MB4236.namprd12.prod.outlook.com
 ([fe80::91ac:1f2d:b4ca:c0a4]) by DM6PR12MB4236.namprd12.prod.outlook.com
 ([fe80::91ac:1f2d:b4ca:c0a4%6]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 21:51:50 +0000
Subject: Re: [PATCH] drm/amd/display: add HDCP caps debugfs
To: Harry Wentland <hwentlan@amd.com>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20200224195553.28137-1-Bhawanpreet.Lakha@amd.com>
 <b6d16c38-0945-3915-05ba-6194db5d2a50@amd.com>
From: Bhawanpreet Lakha <Bhawanpreet.lakha@amd.com>
Message-ID: <aa3c7758-0597-fb2e-e89b-7a66263eb54a@amd.com>
Date: Mon, 24 Feb 2020 16:51:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <b6d16c38-0945-3915-05ba-6194db5d2a50@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::36)
 To DM6PR12MB4236.namprd12.prod.outlook.com
 (2603:10b6:5:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.29.2.119] (165.204.55.250) by
 YT1PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 21:51:49 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ede3c81a-b5a7-403d-87b0-08d7b973c075
X-MS-TrafficTypeDiagnostic: DM6PR12MB2906:|DM6PR12MB2906:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2906B736D0F42B46D55B80FDF9EC0@DM6PR12MB2906.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(199004)(189003)(31686004)(8676002)(6486002)(81166006)(81156014)(316002)(52116002)(5660300002)(66476007)(66946007)(66556008)(31696002)(16576012)(8936002)(478600001)(16526019)(2616005)(186003)(36756003)(53546011)(86362001)(956004)(2906002)(4326008)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2906;
 H:DM6PR12MB4236.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNlnqGbbJE9SnslaZiy1cV/9JSv7meXcaCOD+UgFp5ZTmVtmFSCVQVArfb/W9Pzd+/HVvqWH/tFJmdbK+3z18tb76ORvZYOifQLh/sjonsJlaVz4+iBg+IbHJW82VTE4ALMI5xud7h5FH4MHibMKMPI1Uhs5GkT9PW4Oba9zryzMBhmTTju/Yfk6UAPVZ2QzgdqkhcwLsKD5Io9/amGo2PAs9+wSkrfJvoLFyc6fJJrqFy5pgZOse5OcRnfEP2ZJqGJ2m27LU+jQDAta0Z+obAGb9FMsZcPeDk/bD5eqfrK4D4aR+OBM3zX2yP05w1ZCApLmXV+RXkcZQ1OXILvXWr1AJA2agrOagzmkB9vklCGFJ5hKrL6Hbx0DpGsawQro4HwyimOSRRISA2VPGsk9gIO6c+bJFEyWq3wglsIYBOvcemr/e0DsroPiv8rp4mEO
X-MS-Exchange-AntiSpam-MessageData: W9R3NfpbFkfwG1zyqtkL+beh6uNBKPRbIK+MGJMLdXYbIq/2+ewZCe44OKqMZjMcLSP0jpXFPhUNV3bsOzQm3hVmFzuuhfL27LZ05r8ayN0/tTGWY8lvm6uQEOxZ0+LXB9UCqeKL4+1IzgkisxRbVg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede3c81a-b5a7-403d-87b0-08d7b973c075
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 21:51:49.9431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcLtJ/C1SU7kONbCwuIFcLjywIsMvqghTuAkTL6HBOmLzk2n7YMSFJXJPjjUtt7f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2906
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
Cc: harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-02-24 4:15 p.m., Harry Wentland wrote:
>
> On 2020-02-24 2:55 p.m., Bhawanpreet Lakha wrote:
>> Add debugfs to get HDCP capability. This is also useful for
>> kms_content_protection igt test.
>>
>> Use:
>> 	cat /sys/kernel/debug/dri/0/DP-1/hdcp_sink_capability
>> 	cat /sys/kernel/debug/dri/0/HDMI-A-1/hdcp_sink_capability
>>
>> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
>> ---
>>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 61 +++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> index ead5c05eec92..52982c8c871f 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> @@ -815,6 +815,44 @@ static int vrr_range_show(struct seq_file *m, void *data)
>>   	return 0;
>>   }
>>   
>> +#ifdef CONFIG_DRM_AMD_DC_HDCP
>> +/*
>> + * Returns the HDCP capability of the Display (1.4 for now).
>> + *
>> + * NOTE* Not all HDMI displays report their HDCP caps even when they are capable.
>> + * Since its rare for a display to not be HDCP 1.4 capable, we set HDMI as always capable.
>> + *
>> + * Example usage: cat /sys/kernel/debug/dri/0/DP-1/hdcp_sink_capability
>> + *		or cat /sys/kernel/debug/dri/0/HDMI-A-1/hdcp_sink_capability
>> + */
>> +static int hdcp_sink_capability_show(struct seq_file *m, void *data)
>> +{
>> +	struct drm_connector *connector = m->private;
>> +	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
>> +	bool hdcp_cap, hdcp2_cap;
>> +
>> +	if (connector->status != connector_status_connected)
>> +		return -ENODEV;
>> +
>> +	seq_printf(m, "%s:%d HDCP version: ", connector->name, connector->base.id);
>> +
>> +	hdcp_cap = dc_link_is_hdcp14(aconnector->dc_link);
>> +	hdcp2_cap = dc_link_is_hdcp22(aconnector->dc_link);
>> +
>> +
>> +	if (hdcp_cap)
>> +		seq_printf(m, "%s ", "HDCP1.4");
>> +	if (hdcp2_cap)
>> +		seq_printf(m, "%s ", "HDCP2.2");
>> +
>> +	if (!hdcp_cap && !hdcp2_cap)
>> +		seq_printf(m, "%s ", "None");
>> +
>> +	seq_puts(m, "\n");
>> +
>> +	return 0;
>> +}
>> +#endif
>>   /* function description
>>    *
>>    * generic SDP message access for testing
>> @@ -940,6 +978,9 @@ static ssize_t dp_dpcd_data_read(struct file *f, char __user *buf,
>>   DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
>>   DEFINE_SHOW_ATTRIBUTE(output_bpc);
>>   DEFINE_SHOW_ATTRIBUTE(vrr_range);
>> +#ifdef CONFIG_DRM_AMD_DC_HDCP
>> +DEFINE_SHOW_ATTRIBUTE(hdcp_sink_capability);
>> +#endif
>>   
>>   static const struct file_operations dp_link_settings_debugfs_fops = {
>>   	.owner = THIS_MODULE,
>> @@ -995,12 +1036,23 @@ static const struct {
>>   		{"test_pattern", &dp_phy_test_pattern_fops},
>>   		{"output_bpc", &output_bpc_fops},
>>   		{"vrr_range", &vrr_range_fops},
>> +#ifdef CONFIG_DRM_AMD_DC_HDCP
>> +		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
>> +#endif
>>   		{"sdp_message", &sdp_message_fops},
>>   		{"aux_dpcd_address", &dp_dpcd_address_debugfs_fops},
>>   		{"aux_dpcd_size", &dp_dpcd_size_debugfs_fops},
>>   		{"aux_dpcd_data", &dp_dpcd_data_debugfs_fops}
>>   };
>>   
>> +#ifdef CONFIG_DRM_AMD_DC_HDCP
>> +static const struct {
>> +	char *name;
>> +	const struct file_operations *fops;
>> +} hdmi_debugfs_entries[] = {
>> +		{"hdcp_sink_capability", &hdcp_sink_capability_fops}
>> +};
>> +#endif
>>   /*
>>    * Force YUV420 output if available from the given mode
>>    */
>> @@ -1066,6 +1118,15 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
>>   	debugfs_create_file_unsafe("force_yuv420_output", 0644, dir, connector,
>>   				   &force_yuv420_output_fops);
>>   
>> +#ifdef CONFIG_DRM_AMD_DC_HDCP
>> +	if (connector->base.connector_type == DRM_MODE_CONNECTOR_HDMIA) {
> Your patch description mentions DP and HDMI but here you're only
> creating it for HDMI. Should we create it for all HDCP-capable signal
> types, i.e. DP and HDMI?
>
> Harry

There is a loop above that is called for dp_debugfs_entries[]. I have 
added the HDCP debugfs to that struct so no need to recreate the loop.

Bhawan

>> +		for (i = 0; i < ARRAY_SIZE(hdmi_debugfs_entries); i++) {
>> +			debugfs_create_file(hdmi_debugfs_entries[i].name,
>> +					    0644, dir, connector,
>> +					    hdmi_debugfs_entries[i].fops);
>> +		}
>> +	}
>> +#endif
>>   }
>>   
>>   /*
>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
