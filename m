Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBACFC2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 10:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3B92074B
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 10:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z7dWcdT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3B92074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48EC89FC0;
	Mon, 28 Sep 2020 10:54:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB56389FC0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 10:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cS4tvPG4T5pyVtfX4Q9ql4Ur3uHLjVb6vVJOxT/2SFqDRkYMr7+HeNvTs87t9e1ZTdS7yI9gsdefuUuWU3LFlGwf510YFF+KyuFhHsJ+p+XaRV3p8bxLP7gIf686X1NNIX1tvn9sKffedqmVnRdolHe3A3pFbLLSXYXeunTICHMG+P8RsB7H5e621J5ehvr6ov2revfYrbU5lJe2DA1wN3lBNVuoN6Cg+XLGAFvDdUGhNRBYHJrPbcHr7opaLn49ugklFUbgWuAKP/v9tTx2YpQvFkO5d7wKrM6ppzXdyQw9DAH1geDoH9Otu31JGH/RfryEjiemvmWErJtg5/aR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcrFnu2Fww2AfTBEEBslyGyPLbZv4MuS2m936w2/d1A=;
 b=mhPpQHyi+Y07WFuHi54rsgnN9w5iIMX6s3IA2ExaqvbErNgfZtWQUMQkhbTDn3JLNnVptRBl4wIebQbm5MGAnvdvfO1efix3lVwpK/V3jkGLt2wZYQb7wH/uM7qX+LBBqEYZCd00Wpks03FTj69B8isIFUnQawinOuMvJ9JJ9F2P+Nx+n+nb3rhQ4A4EZ0ApC4A03iHP0fN+9BHi+bkRW8Zj1laxs8+X8VU4a/eCBAi2ZnrgfUU+69kENbeKE4CyqmKI0/QKlukKpkgqWh4G61n55WMz9s5AKLr9rK3AM1uvHh0ZvJp70QLTI8Iiubuf3TOHgf7uSjaRXJLkIAK2Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcrFnu2Fww2AfTBEEBslyGyPLbZv4MuS2m936w2/d1A=;
 b=z7dWcdT23gNwNdO7XEcsEd+E6aq1wuNxaG6a4+Pqg7dmfB1mYVHqLuUXQXCFXm8tUDfeH0+RBzlQFk8qwcz1EX9hSsqzxwB7ksaFbqpNNCxRCO7FJvp/deAbHUKzdLJrDS2nFWbT9QJn2Sql3wl+yeVFlNP43rgaWCu/7MaK/ME=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 10:54:39 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 10:54:39 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amd/amdkfd: Surface files in Sysfs to allow users
 to get number of compute units that are in use.
Thread-Topic: [PATCH 3/3] drm/amd/amdkfd: Surface files in Sysfs to allow
 users to get number of compute units that are in use.
Thread-Index: AQHWk4fADElgAdj+XEqku10i7mXUj6l94rAQ
Date: Mon, 28 Sep 2020 10:54:39 +0000
Message-ID: <DM6PR12MB37215F5E0A0504A55FC6FE8385350@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200925220329.31071-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20200925220329.31071-1-Ramesh.Errabolu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-28T10:54:35Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c0fdbce7-3a7f-4ddb-9700-0000a1d37f28;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-28T10:54:30Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 2cdeb31d-e6ab-47fd-a60b-0000e07a1d38
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-28T10:54:37Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 513b1e73-3462-426f-b44c-0000f17532d2
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1c80:6680:5c68:43d4:fbcf:8988]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc4f442d-614e-4778-d466-08d8639ce5ed
x-ms-traffictypediagnostic: DM6PR12MB4233:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4233E5E808BC41B53FD8961B85350@DM6PR12MB4233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5tJBcVx6t81y6kTG1TxSJu7oBDCgZ5W23txSBLqzUnlrNCxi7/dlWzB5BXA15xkvHORwFBW0LWQ9sSNp+fBF76HcpjK/RLb9XFeTkrsfcae1ylVd69z3YHZrRd5E02Rr8ohWpQ8QpHfZpN/Nh2RoQS5XEjKeq9jWCyIOlvx0fNFxfbMMPyL1BFeqvzaDBfqzFaVrSx0eiksZJ1VsVaQkTo+LbkzXmWqtaV7k6RpbXc/KA13ZH4yC0nCO5uoiDb18hZ2jnklmgUuG+bjetQgtcjb1tnpF0Bxeey9aETEAw46r86DpHtjV8BIQ9JPGEmk+/AiCR2/HvBanjefhix7H1vytkUYOBgG0aG/iUKIdF7LgVGMIMq0aMHsctbqGV1tF83SQm1LhaVezpYMgoUQuxphR9dVWO/DlgZu5+xeDG/2Rydw4AdWo5WrHiWC22xEo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(33656002)(5660300002)(316002)(76116006)(66946007)(71200400001)(52536014)(45080400002)(110136005)(66476007)(66556008)(64756008)(66446008)(478600001)(7696005)(55016002)(8936002)(9686003)(4326008)(53546011)(8676002)(2906002)(6506007)(86362001)(966005)(186003)(83080400001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 487Y+1fi6h8Ed5dUVFjHWyM0IUtnA0GwnhpwTUz4mX8YDW5+Fs5SGA4YN8NikWqnYXCpa8zcIv6aneiecE2x0lHMoSojJyH7ZKZkSHlDlJzu+vAnEob7Hzp92Gr4tXC9ywp0NJhuruPLhwOUTdwER77sclhb7pMmpH8QVHv9H6jCQZNBLBKeuBUblquv74yFK6RxnQPjFqH8u2JjnUBDei/qRR8D/ksXhraJe6D8hKu0OTZK5jJVTmToNfRwCFUy0Nmxhoqfbdjxlvym/+JgruyyQ5ej/UvPX2zJjOiC0JlZ4cElDIspHATydyhiON0bW4NE6e14c6yTQE6wA4jHZ1P7mcAtN8Bk4ONqAr6W0sQb91idruyRKABI7YDuUWEI4ZNusnGGtKMy3RTN2TvUBcSuFWWxeExYvb4mcbQtLsSnVHnNyYkx2+XEVa4JfSPML80rfHZz6WnpmBIN9HKQtx15YmpnX5kJGAd3RfPCG1a663oCZG0+4cUCcswOhjQkHEa84tLZLV7gY13YnQm2HcZlLPBrRDXbAtFE4SnYySsf+MLhs2jM0F54RFVXZtkLa8Q7e7sN5KGklcFMe+f72CY88demZXmthrP0NE1jswZ+1bf/OWkTtS4VTfQ/boqdkTbKhdv7rZ8zx7+4xhRdcqFU091xebTqkVNynNsLy1Xu+W1cxx7mFtEKTVF5Og4+Twmh8kqwD40bFN+bTmv2sQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4f442d-614e-4778-d466-08d8639ce5ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 10:54:39.5572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNV3652hWm9ZM7b8KauOpFrtu7GA4BPOBdXtLrYxYttHMHicyvclTSHR21Oci0UUTNC++Yigmyl5rV2YYDHR7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
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
Cc: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Some minor things inline

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ramesh Errabolu
> Sent: Friday, September 25, 2020 6:03 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
> Subject: [PATCH 3/3] drm/amd/amdkfd: Surface files in Sysfs to allow users to get number
> of compute units that are in use.
> 
> [Why]
> Allow user to know how many compute units (CU) are in use at any given
> moment.
> 
> [How]
> Surface files in Sysfs that allow user to determine the number of compute
> units that are in use for a given process. One Sysfs file is used per
> device.
> 
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 25 +++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 68 +++++++++++++++++++++++-
>  2 files changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 56f92cfff591..3df2b9936458 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -705,6 +705,31 @@ struct kfd_process_device {
> 
>  	struct kobject *kobj_stats;
>  	unsigned int doorbell_index;
> +
> +	/*
> +	 * @cu_occupancy: Reports occupancy of Compute Units (CU) of a process
> +	 * that is associated with device encoded by "this" struct instance. The
> +	 * value reflects CU usage by all of the waves launched by this process
> +	 * on this device. A very important property of occupancy parameter is
> +	 * that its value is a a snapshot of current use.

is a snapshot

> +	 *
> +	 * Following is to be noted regarding how this parameter is reported:
> +	 *
> +	 *  The number of waves that a CU can launch is limited by couple of
> +	 *  parameters. These are encoded by struct amdgpu_cu_info instance
> +	 *  that is part of every device definition. For GFX9 devices this
> +	 *  translates to 40 waves (simd_per_cu * max_waves_per_simd) when waves
> +	 *  do not use scratch memory and 32 waves (max_scratch_slots_per_cu)
> +	 *  when they use. This could change for future devices and therefore

when they do use scratch memory

> +	 *  this example should be considered as a guide.
> +	 *
> +	 *  All CU's of a device are available for the process. This may not be true
> +	 *  under certain conditions - e.g. CU masking.
> +	 *
> +	 *  Finally number of CU's that are occupied by a process is affected by both
> +	 *  number of CU's a device has along with number of other competing processes
> +	 */
> +	struct attribute attr_cu_occupancy;
>  };
> 
>  #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 17d909c86f50..26b716b5eb23 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -249,6 +249,52 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>  	}
>  }
> 
> +/**
> + * @kfd_get_cu_occupancy() - Collect number of waves in-flight on this device
> + * by current process. Translates acquired wave count into number of compute units
> + * that are occupied.
> + *
> + * @atr: Handle of attribute that allows reporting of wave count. The attribute
> + * handle encapsulates GPU device it is associated with, thereby allowing collection
> + * of waves in flight, etc
> + *
> + * @buffer: Handle of user provided buffer updated with wave count
> + *
> + * Return: Number of bytes written to user buffer or an error value
> + */
> +static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
> +{
> +	int cu_cnt;
> +	int wave_cnt;
> +	int max_waves_per_cu;
> +	struct kfd_dev *dev = NULL;
> +	struct kfd_process *proc = NULL;
> +	struct kfd_process_device *pdd = NULL;
> +
> +	pdd = container_of(attr, struct kfd_process_device, attr_cu_occupancy);
> +	dev = pdd->dev;
> +	if (dev->kfd2kgd->get_cu_occupancy == NULL)
> +		return -EINVAL;
> +
> +	cu_cnt = 0;
> +	proc = pdd->process;
> +	if (pdd->qpd.queue_count == 0) {
> +		pr_debug("Gpu-Id: %d has no active queues for process %d\n",
> +			 dev->id, proc->pasid);
> +		return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
> +	}
> +
> +	/* Collect wave count from device if it supports */
> +	wave_cnt = 0;
> +	max_waves_per_cu = 0;
> +	dev->kfd2kgd->get_cu_occupancy(dev->kgd, proc->pasid, &wave_cnt,
> +			&max_waves_per_cu);
> +
> +	/* Translate wave count to number of compute units */
> +	cu_cnt = (wave_cnt + (max_waves_per_cu - 1)) / max_waves_per_cu;
> +	return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
> +}
> +
>  static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>  			       char *buffer)
>  {
> @@ -344,6 +390,7 @@ static ssize_t kfd_procfs_queue_show(struct kobject *kobj,
> 
>  	return 0;
>  }
> +
>  static ssize_t kfd_procfs_stats_show(struct kobject *kobj,
>  				     struct attribute *attr, char *buffer)
>  {
> @@ -359,6 +406,10 @@ static ssize_t kfd_procfs_stats_show(struct kobject *kobj,
>  				PAGE_SIZE,
>  				"%llu\n",
>  				jiffies64_to_msecs(evict_jiffies));
> +
> +	/* Sysfs handle that gets CU occupancy is per device */
> +	} else if (strcmp(attr->name, "cu_occupancy") == 0) {
> +		return kfd_get_cu_occupancy(attr, buffer);
>  	} else
You should use } else { here, even for a single line, see https://www.kernel.org/doc/html/v4.10/process/coding-style.html right above section 3.1. Annoyingly, checkpatch doesn't catch this.
>  		pr_err("Invalid attribute");
> 
> @@ -466,6 +517,7 @@ static int kfd_procfs_add_sysfs_stats(struct kfd_process *p)
>  	 * Create sysfs files for each GPU:
>  	 * - proc/<pid>/stats_<gpuid>/
>  	 * - proc/<pid>/stats_<gpuid>/evicted_ms
> +	 * - proc/<pid>/stats_<gpuid>/cu_occupancy
>  	 */
>  	list_for_each_entry(pdd, &p->per_device_data, per_device_list) {
>  		struct kobject *kobj_stats;
> @@ -496,6 +548,19 @@ static int kfd_procfs_add_sysfs_stats(struct kfd_process *p)
>  		if (ret)
>  			pr_warn("Creating eviction stats for gpuid %d failed",
>  					(int)pdd->dev->id);
> +
> +		/* Add sysfs file to report compute unit occupancy */
> +		if (pdd->dev->kfd2kgd->get_cu_occupancy != NULL) {
> +			pdd->attr_cu_occupancy.name = "cu_occupancy";
> +			pdd->attr_cu_occupancy.mode = KFD_SYSFS_FILE_MODE;
> +			sysfs_attr_init(&pdd->attr_cu_occupancy);
> +			ret = sysfs_create_file(kobj_stats,
> +						&pdd->attr_cu_occupancy);
> +			if (ret)
> +				pr_warn("Creating %s failed for gpuid: %d",
> +					pdd->attr_cu_occupancy.name,
> +					(int)pdd->dev->id);
> +		}
>  	}
>  err:
>  	return ret;
> @@ -537,7 +602,6 @@ static int kfd_procfs_add_sysfs_files(struct kfd_process *p)
>  	return ret;
>  }
> 
> -
>  void kfd_procfs_del_queue(struct queue *q)
>  {
>  	if (!q)
> @@ -909,6 +973,8 @@ static void kfd_process_wq_release(struct work_struct *work)
>  			sysfs_remove_file(p->kobj, &pdd->attr_vram);
>  			sysfs_remove_file(p->kobj, &pdd->attr_sdma);
>  			sysfs_remove_file(p->kobj, &pdd->attr_evict);
> +			if (pdd->dev->kfd2kgd->get_cu_occupancy != NULL)
> +				sysfs_remove_file(p->kobj, &pdd->attr_cu_occupancy);
>  			kobject_del(pdd->kobj_stats);
>  			kobject_put(pdd->kobj_stats);
>  			pdd->kobj_stats = NULL;
> --
> 2.27.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.or
> g%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7C4ed773ec69b04a9d2ee308d8619
> ee024%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637366682305777071&amp
> ;sdata=1NPpCMCB8dfWGwIokNotPm1pJU4AMkeurhcIe0y%2FIaw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
