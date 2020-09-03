Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528ACC433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 15:25:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A0420786
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 15:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eujMW5lU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A0420786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC9F46E17A;
	Thu,  3 Sep 2020 15:25:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E727C6E17A
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 15:25:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1UmAezwMLKIcXE0Tott4+a+50hrfWiRrumWxAyL+Fy/9qxMTYn1inLPuOYJMCU8wIf39/Bkg1Q/TxF8mkYP4UYgzmRPaDqYbOUkhORHx39CLZCuKPD+3xr2DTwrPYm8GBus5PLOGlfK6EjVk0AUPV6+KSVZDNapex/de9bhCSqcr13SWTt6gJwcQus1aAvrRQamLb0E7h7KUoPXaE7SxYaNrSCN/GQWZIcqagXsjmAqgmvi438X/08UHsJrCPyHLO3qa4mZ/rsJbmxTEU9TDYaOtMN2NF2vO6+YScrmEUvCGSwQdt6AvwqVm/0yaQLgGSswo4mNnZ4rCsxezSyKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ajRytHFwTHmtydkxA4fcTT+qh6S5mFLfPU1LfR5xtY=;
 b=EvOhch6uUiHrpFCg8FPhQ1Vno8db88Rz1Cmxniai5cac87ydoE5elVHa0ZXs/96Z0iU6njROujJ82wmApTWMo/X/LoVkWmLZRTawd8UBeOD6XWkD0SKw9befHFDjbGjyT3inqjb4nZ4rHx30uk/1WDaNId1/Sq/BC1kGG2/EzD274n7Um6NWDoUHaAQUbsJs8Fw4xhPHWI1O5yo9fpwUYyZWSqPTiF6qWLwlEz98IXAyYm4XexyltajoVEqwEctw5P4J6OuSbh0E3tvgkxBWEhSqYE7opfGEHuuitm344WD71eaXIJTvgzDaosSs9tNGHNaakov0IN16P1ragbYQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ajRytHFwTHmtydkxA4fcTT+qh6S5mFLfPU1LfR5xtY=;
 b=eujMW5lUSuz3uMKf2PWg/w7NikZndmexUgUPLzRV1QEliYAsc4K7e+RtzpCKT4GqBiHqtCsaAczrpIV4u59k9GQiNKDF07YBjwkUse1XciuCtqQmdO3ycEE2vUZOTjJFFkTAzAG8DS1dcQKk5XyAn6zvHhtJ7Ce6AATH5G1u600=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.25; Thu, 3 Sep 2020 15:25:05 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 15:25:05 +0000
Subject: Re: [PATCH v4 1/8] drm/amdgpu: Avoid accessing HW when suspending SW
 state
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20200902215612.GA271679@bjorn-Precision-5520>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <a573c83d-6ca1-d2fe-89a4-6df51ae7ad2f@amd.com>
Date: Thu, 3 Sep 2020 11:25:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200902215612.GA271679@bjorn-Precision-5520>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::24) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0115.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 15:25:04 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5170419-8573-452d-bf85-08d8501d8851
X-MS-TrafficTypeDiagnostic: DM6PR12MB2812:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2812F1F2DC771D711A7110E4EA2C0@DM6PR12MB2812.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VuFflTwDoVVVQP81tGzW/x6BZHc1WKLu+JyxI3O0fS+l+L00vHlf2J/p1XOdKWh03b/tPWzCALagNbi0Vh7nj3Q/P3Bgp7BajBX6kElnUrASYkTlrobsHFj4Cs8lWeVCPRXJTdMTisFYxl2khPTe+WOjXIJDsr46MYQ0/R2aip7GFPBWqZq5MwQe+XXlUf2ce2LTdhZAwYlrTFwV24cRpKS5OtE0qI0r0Y0pgnemdxA4KU6FeXi0j6X1fdZ/qhwbTNvYUfqSijG3iQKy0rkZnjBM+go0Rz6gOYEH6TQlN/t3scBwD6l0Dv95q3ingp2Wmi6EUBGG57fJq16awUFT9j/TtT0785kgWwEiDh5+7L9LIjiY1VNr1WKaSP+etQGn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(6916009)(956004)(2616005)(66556008)(52116002)(26005)(6486002)(53546011)(31696002)(66946007)(33964004)(86362001)(66476007)(36756003)(8676002)(5660300002)(83380400001)(4326008)(16576012)(2906002)(8936002)(478600001)(15650500001)(186003)(316002)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: P8DewEDm7kwjFm7I6Gki/RS5jJyZrj1Y0qRoQORRhT6J31j+dMP+nr6LZZT84PzqAyhFzwX9YjZ0gRxBR9oRI88CWbeo1EccXYb2s3EleQDlIflshzvKiU/s3dwMyszqLxI3koI+RdOpxmkBBHzZZbFmqSH3NR1zjY05F4WNYaV5N6X1STLw9Nd+OPilZKOlBBMrGQUbMjWNODO5nzF7lHdhXSvoTHkIWy4Y4q83vTsXw+SsBVXy9lTORY61Jq9NJcxWYrak5dN7A0TaAbZY5jqQdrozOaSz5nTTQTNjPbGU9u706zcD4MXT3FwBiweS5Q64mVkvXblxLmwV4elBqbUco6uDCtjMobuT5uHlJE3lM3dDrW7on2wPPYKQuXDEkreQHTWH+wCsGKkgBS94f7mCVBv02jz0zbVwZbIEuLTNi+KbQB5NzkBn3idaoQtXaHm8U9VkotarPPaLe2uAY2S6XqJmflbNiW4kVX8P3aQr5eXA7R+6gk+lIhBdHliCYfe2eZZpHhWgkJkov+NxkoDRICtURtX9suUC8DzjdREMSQahLmHKkuNE2Xl8ElT5YrYuMZ09U4nddRBMKS7Ozn8uzj6prCLmr93QS3AylDEHhLsQ4CnpyP1KeQhIG5NBrA6/46PBuFfh5/pceNZjDA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5170419-8573-452d-bf85-08d8501d8851
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 15:25:04.6059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhGiAIDcemyxcjQxa2oECOgT8wE/VKqLcrKpKYjncyjBMQ619fE07b7J8oIEpWXcyI0xNLg/hYsaaIGcfayiwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
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
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, linux-pci@vger.kernel.org,
 nirmodas@amd.com, amd-gfx@lists.freedesktop.org, bhelgaas@google.com,
 luben.tuikov@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 Dennis.Li@amd.com
Content-Type: multipart/mixed; boundary="===============0602137152=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0602137152==
Content-Type: multipart/alternative;
 boundary="------------2E8BFA9A565B3A1D10A3CA3A"
Content-Language: en-US

--------------2E8BFA9A565B3A1D10A3CA3A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/2/20 5:56 PM, Bjorn Helgaas wrote:
> On Wed, Sep 02, 2020 at 02:42:03PM -0400, Andrey Grodzovsky wrote:
>> At this point the ASIC is already post reset by the HW/PSP
>> so the HW not in proper state to be configured for suspension,
>> some blocks might be even gated and so best is to avoid touching it.
>>
>> v2: Rename in_dpc to more meaningful name
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  6 +++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 +++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 ++++++++------
>>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |  3 +++
>>   6 files changed, 65 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index c311a3c..b20354f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -992,6 +992,7 @@ struct amdgpu_device {
>>   	atomic_t			throttling_logging_enabled;
>>   	struct ratelimit_state		throttling_logging_rs;
>>   	uint32_t			ras_features;
>> +	bool                            in_pci_err_recovery;
>>   };
>>   
>>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 74a1c03..1fbf8a1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -319,6 +319,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>>   {
>>   	uint32_t ret;
>>   
>> +	if (adev->in_pci_err_recovery)
>> +		return 0;
> I don't know the whole scheme of this, but this looks racy.
>
> It looks like the normal path through this function is the readl(),
> which I assume is an MMIO read from the PCI device.  If this is called
> after a PCI error occurs, but before amdgpu_pci_slot_reset() sets
> adev->in_pci_err_recovery, the readl() will return 0xffffffff.
>
> If this is called after amdgpu_pci_slot_reset() sets
> adev->in_pci_err_recovery, it will return 0.  Do you really want those
> two different cases?


This is not intended to to avoid hardware accessed by other threads when doing 
PCI recovery (answers also Denis's question) -
in slot reset callback we suspend and then resume the IP blocks so we can bring 
the SW and HW back to operational. For this
we first call IPs suspend and then resume. But the ASIC was already reset by the 
time we execute this code and so there
is a misalignment between the HW and the SW states. The HW is in clean 'fresh 
poweron or init' state while the SW is in running state.
So I want to align SW state with the HW state by calling suspend IPs sequence 
without touching the HW and so this flag is used to
skip all HW registers r/w while I do it. Regarding other threads which might 
access the registers this should not happen as I sopped all new internal
and external command submissions  and took GPU reset device lock so at least we 
are protected here same as during ordinary GPU reset.
Yes, it's not 100% proof and there still might be some accesses from other 
threads during this time and they will return 0xffffffff values.

Andrey


>
>>   	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>>   		return amdgpu_kiq_rreg(adev, reg);
>> @@ -4773,7 +4809,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>   
>>   	pci_restore_state(pdev);
>>   
>> +	adev->in_pci_err_recovery = true;
>>   	r = amdgpu_device_ip_suspend(adev);
>> +	adev->in_pci_err_recovery = false;
>>   	if (r)
>>   		goto out;

--------------2E8BFA9A565B3A1D10A3CA3A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/2/20 5:56 PM, Bjorn Helgaas wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20200902215612.GA271679@bjorn-Precision-5520">
      <pre class="moz-quote-pre" wrap="">On Wed, Sep 02, 2020 at 02:42:03PM -0400, Andrey Grodzovsky wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">At this point the ASIC is already post reset by the HW/PSP
so the HW not in proper state to be configured for suspension,
some blocks might be even gated and so best is to avoid touching it.

v2: Rename in_dpc to more meaningful name

Signed-off-by: Andrey Grodzovsky <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky@amd.com">&lt;andrey.grodzovsky@amd.com&gt;</a>
Reviewed-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 ++++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |  3 +++
 6 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c311a3c..b20354f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -992,6 +992,7 @@ struct amdgpu_device {
 	atomic_t			throttling_logging_enabled;
 	struct ratelimit_state		throttling_logging_rs;
 	uint32_t			ras_features;
+	bool                            in_pci_err_recovery;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 74a1c03..1fbf8a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -319,6 +319,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 {
 	uint32_t ret;
 
+	if (adev-&gt;in_pci_err_recovery)
+		return 0;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I don't know the whole scheme of this, but this looks racy.

It looks like the normal path through this function is the readl(),
which I assume is an MMIO read from the PCI device.  If this is called
after a PCI error occurs, but before amdgpu_pci_slot_reset() sets
adev-&gt;in_pci_err_recovery, the readl() will return 0xffffffff.

If this is called after amdgpu_pci_slot_reset() sets
adev-&gt;in_pci_err_recovery, it will return 0.  Do you really want those
two different cases?</pre>
    </blockquote>
    <p><br>
    </p>
    <p>This is not intended to to avoid hardware accessed by other
      threads when doing PCI recovery (answers also Denis's question) -
      <br>
      in slot reset callback we suspend and then resume the IP blocks so
      we can bring the SW and HW back to operational. For this<br>
      we first call IPs suspend and then resume. But the ASIC was
      already reset by the time we execute this code and so there<br>
      is a misalignment between the HW and the SW states. The HW is in
      clean '<span style="color: rgb(0, 0, 0); font-family: serif;
        font-size: 16px; font-style: normal; font-variant-ligatures:
        normal; font-variant-caps: normal; font-weight: 400;
        letter-spacing: normal; orphans: 2; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(252, 252, 252); text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;">fresh poweron</span> or init' state
      while the SW is in running state.<br>
      So I want to align SW state with the HW state by calling suspend
      IPs sequence without touching the HW and so this flag is used to<br>
      skip all HW registers r/w while I do it. Regarding other threads
      which might access the registers this should not happen as I
      sopped all new internal<br>
      and external command submissions&nbsp; and took GPU reset device lock
      so at least we are protected here same as during ordinary GPU
      reset.<br>
      Yes, it's not 100% proof and there still might be some accesses
      from other threads during this time and they will return
      0xffffffff values. <br>
    </p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20200902215612.GA271679@bjorn-Precision-5520">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 	if (!(acc_flags &amp; AMDGPU_REGS_NO_KIQ) &amp;&amp; amdgpu_sriov_runtime(adev))
 		return amdgpu_kiq_rreg(adev, reg);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">@@ -4773,7 +4809,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 
 	pci_restore_state(pdev);
 
+	adev-&gt;in_pci_err_recovery = true;
 	r = amdgpu_device_ip_suspend(adev);
+	adev-&gt;in_pci_err_recovery = false;
 	if (r)
 		goto out;
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------2E8BFA9A565B3A1D10A3CA3A--

--===============0602137152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0602137152==--
