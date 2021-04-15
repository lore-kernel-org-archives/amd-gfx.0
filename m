Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB6FC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 15:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B3CF61158
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 15:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3CF61158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAD7A6EA6F;
	Thu, 15 Apr 2021 15:40:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 353C06EA6F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 15:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrkYr7UZGaoBFl8Ko1rvsJOgNHJLuRHWQAi/vaGWZl9sYqNF9JjRg2cO2oHPbdH1/Sq4HtKYfRoOKjg/5Efbsq7JsBwFDEUFZCZ4fy/ElhkD4smgxkLU38UGT7Hs2IY1bvXeVtWBGxtdBh4za0cRc2ZjrAj9t595GEM2tWsmpaWDZef+e0HkwHOxDL0yVEInw5VL42qqZfhPrlmQIK+m5l+Rc+wUsATVEmoPWjm5P3aFMuU6aPsA+IyWACEu+Q05nP3vunaV2CAAyk3NXKw934QD8CDMZa5XBVfoVkN213g9DWF5L0AVMB5OdF+jyAEut/s5GfDNuF2EBr5QNyd+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4WTKQTugeFBXrlOjRdO/t4GGyjbre1ahwrq4vHg07w=;
 b=Ph8lDsm95ymSgYf8qp2qlIxzphTzEAfW5QXRc5RLTY72tKQINhIvP9kzcuKizBEjSph5fqFKlIFVZgoDDeofacsP2jp9nlvKEq27n9ZpvP6gqY7oJJotE/X2qT/RODB6AnuJL0f/Jh4baUkbZjqsmDlMQK+LBEzcfdhwMloyqk2WP1As4SPpqtHFNFy/8eF0Qqnqv58/XW6FeFqKdvhu0agay55dALLJoxD6yVKxhQ/4dhx7oLND3r5zXcR0QIFmJMx8UcO8t3NOStI1qL1sdvmxyFqCe8COVntC2n87/OIMIU/qV8Q50SyccolfIDBHP9yFqHFPAjovWIiBK+0kOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4WTKQTugeFBXrlOjRdO/t4GGyjbre1ahwrq4vHg07w=;
 b=rJ8Ul9gdDXGpfmgN542oLjM3D7YHAOEVG9OiUvVWQDJZ68/8nBDwQpVchbKpDDdnDHtmOGZF4EFDS52FNM/oUnVWbuf7Z/UkMF2BuHGmJBG0c1iHK5HL/y8pbfKnBXKkXO3khQX/NPMrSkkPVwYWm+e331/9mlAwe2oIzlvP6CE=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB3417.namprd12.prod.outlook.com (2603:10b6:5:118::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Thu, 15 Apr
 2021 15:40:21 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e5:ccc4:4120:4b89]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e5:ccc4:4120:4b89%7]) with mapi id 15.20.4020.023; Thu, 15 Apr 2021
 15:40:21 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: use ratelimited print in sdma4 interrupt
Thread-Topic: [PATCH] drm/amdgpu: use ratelimited print in sdma4 interrupt
Thread-Index: AQHXMb4ui8envZRqz0qWNMd2uaXbwqq1t5dA
Date: Thu, 15 Apr 2021 15:40:21 +0000
Message-ID: <DM6PR12MB33245934FDBA5F09EFD27738854D9@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20210415061119.2946390-1-Feifei.Xu@amd.com>
In-Reply-To: <20210415061119.2946390-1-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-15T15:40:20Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=781bf6bc-1008-4b0c-8ab1-04acf13ca028;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [99.250.168.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae94101e-e8db-4b33-4425-08d90024c7b8
x-ms-traffictypediagnostic: DM6PR12MB3417:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3417F705814D867DE029F3CF854D9@DM6PR12MB3417.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:41;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G0zh0+TS/KsXhDa/04CurRTPscVr5H1RCwAQsn5FZqPsaXEZJ/DgUXJ9G4T7nswcdzNAKmtzMSUVHzADSHtqI0gzHWLPinzIlj+KefPs3icWinxK1gs4+3d8r7fi+13A54Prsb3ryIdzXPy6ixDAYuopXa4J3hwFAZyoYrirUUNPQUt5Mwq0hxii4jpL3wmkdcjv1+cZPSgMekD/2pNs9HnSdVaXoWdNyd5VsErPQrGjXfcpWLJ21S2ibJ4wyHxH+MVFhhlVRVeLDB323GRFjGFa58JmBziMiCatPhMmJK3zd17WQ7EeQA0iRoCgU9HaoJ07eVBpAm/kWaNfxXOq22EN+l3wAWM6BP6nOQAR6lOLfbUZRSYDSZsdORXarjZfoYRic/g9rnUi1oIfQsEELyrgSj4QywpBB6kHVUv6NR+XMsPO/OhlytKN2IL2SSkXC8dF0KHPj+QfltaS3NxQ6ydj8SiQol93ESjBuv7RlZtOAPsL+JpLbPk5HurZto6zQHNAhfSnTGzmPv+suQ0d4DHOHXEHMYPSAnt0/hAEyD4WKkfzFtKO+SqzJZD+SFosQVxBY0BGjxhlDPT7KWdKa+JtBZ6P7I2IA0jkRFcgae+q8qGdFsMJ4uxBV0618vKQ2A555VNhMR8TaxJvZP9OT5WVJNE5AZ28J+q6Ba11ZInwp962NDsEXyvoQszWtmaD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(33656002)(55016002)(66476007)(5660300002)(64756008)(38100700002)(66946007)(83380400001)(45080400002)(66556008)(478600001)(71200400001)(26005)(316002)(110136005)(76116006)(86362001)(53546011)(52536014)(66446008)(966005)(6506007)(8676002)(8936002)(186003)(2906002)(9686003)(7696005)(122000001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?p/Kceylfm1kyULBv3r93tfnHLz8jSv19OGFaP2xHHKcGKd7G+xS/mnHXf/8x?=
 =?us-ascii?Q?is9mQPP5KFBDQ14WVEBAuQ5KRIZ9pAH+w55vGyh3bHqs2psZ+bEcO3B9OvWT?=
 =?us-ascii?Q?aeswKUj+lTer7nYOHuf51Lc8PqRfmqD3oq+/5ROJ4Mjz9UxEmcYr5Vd/jHXi?=
 =?us-ascii?Q?ljoPyrhWfehaT2mMoN5xerfM2KdodRKG57ZQjfBjsvTooXqpaFL/REXT+azg?=
 =?us-ascii?Q?hnlEWzjp8BlVkMO1lHKLcsRjuAyu7CZw2sNym07QGJL5gJaqwaM7fNNSaZ+s?=
 =?us-ascii?Q?677eGeq/RQYA7pk0YkUvnOtD6vSms7nwX7/BuwEVdOtfeybrzc+Y7nFk/nKd?=
 =?us-ascii?Q?UvOwAlaXsB+lLdaNcR+k8PC3WtHChjzXO+hbtdOBfqt7y9B8uVuB7gzw5Kvl?=
 =?us-ascii?Q?NTi/psJKQHqlCmzlteEZQuKQyWuffKMmiq1yWdI6TbsfZawDpeq1oct5tsWx?=
 =?us-ascii?Q?o7pWV4ThFon/wABuJnmZohjF03gRhWIE5yk1cvmf+DdxtGFqtepn7m2KamAt?=
 =?us-ascii?Q?VoK731IbejYZLGxFuOASHl+VHXKxXeX6gjiG1TQF0GxQ3Bl6h6mPbQhtgPI0?=
 =?us-ascii?Q?hWRc8/Kmth2QbjaorFn7DcW201CRDPUz1vGm5h0Q1mNf/QbBIBPVl+CdYL99?=
 =?us-ascii?Q?od07SuGQ6OIoDzqRZoO2DTPVLc+x84B2W4VZpq8QBMuvTwcgG5duvW1qym6N?=
 =?us-ascii?Q?/DQvdTjbLiaJJpPUEEBNSD6VdlsSPzthmggy1VQsXZ9GNv1U4LvtqF85TKfa?=
 =?us-ascii?Q?4cnETAe1MhJOyriiB7D/+zg9PqOXQt7ZTONIfe1Yygn3Y5/BOIULPgtwk6E6?=
 =?us-ascii?Q?NXThO+7XBppv2HygBfwQMuZ0gw5YasXubnflLyv4kBpB8Y8zgdipFoy/tszj?=
 =?us-ascii?Q?759q0YXHNoYCAYyJ2p6e7YQzhPC3WOa9r8blSL8ZKwdo5ux0VkEGOy4llHKb?=
 =?us-ascii?Q?EC8OP5a0pUMd2SioYCXZ1jdLBB9jg4bVZaz+ImM+UtSxAtVJQl9WqAB66o6i?=
 =?us-ascii?Q?JemRM1+xduo8ibvjEPLNIxV0d8PYiQN6aSNrLlX1SvjpPmpkwNtcsIsEelOF?=
 =?us-ascii?Q?pvBnjzWudNyQaQOB2EhltanF7/1m6YMzzN3NSAmCTPEI83cQbYGSpiybbsqv?=
 =?us-ascii?Q?zQEI8TRgyrVMMB24+zx78OlS+8taduekKeRDvBd4Wq58ZqI3C71YPJEp9WE5?=
 =?us-ascii?Q?O+bXQufKv6t+SfP0mItgXOx5A2DouJipoORe1oExAK8bqSYjhfui0s/rebWE?=
 =?us-ascii?Q?V1u+7oM63bjut+IGHZb1yTkWAOLqRCdlbhTjRi7jLxMbQTBfRHqyIV42myfj?=
 =?us-ascii?Q?h+qmxuSUGeqX8ocEsqb0Vtrc?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae94101e-e8db-4b33-4425-08d90024c7b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 15:40:21.8141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RC3j6rQkhnUob1Ufp3Uqxc2ngPda5iDijvBv8djAnF1Cmin4Q2jT2szt1cR525Di57w3K8kZwmocxYZryjxQkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3417
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Acked-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Feifei Xu
> Sent: Thursday, April 15, 2021 2:11 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Xu, Feifei <Feifei.Xu@amd.com>
> Subject: [PATCH] drm/amdgpu: use ratelimited print in sdma4 interrupt
> 
> dev_*_ratelimited printing will avoid dmesg flush.
> 
> Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 06247ad454b6..1bc5292ebb33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2218,7 +2218,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device
> *adev,
> 
>  	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
>  	if (instance < 0 || instance >= adev->sdma.num_instances) {
> -		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
> +		dev_err_ratelimited(adev->dev, "sdma instance invalid %d\n", instance);
>  		return -EINVAL;
>  	}
> 
> @@ -2228,7 +2228,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device
> *adev,
>  	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>  	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
> 
> -	dev_info(adev->dev,
> +	dev_info_ratelimited(adev->dev,
>  		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>  		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
>  		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
> @@ -2241,7 +2241,7 @@ static int sdma_v4_0_process_vm_hole_irq(struct
> amdgpu_device *adev,
>  					      struct amdgpu_irq_src *source,
>  					      struct amdgpu_iv_entry *entry)
>  {
> -	dev_err(adev->dev, "MC or SEM address in VM hole\n");
> +	dev_err_ratelimited(adev->dev, "MC or SEM address in VM hole\n");
>  	sdma_v4_0_print_iv_entry(adev, entry);
>  	return 0;
>  }
> @@ -2250,7 +2250,8 @@ static int sdma_v4_0_process_doorbell_invalid_irq(struct
> amdgpu_device *adev,
>  					      struct amdgpu_irq_src *source,
>  					      struct amdgpu_iv_entry *entry)
>  {
> -	dev_err(adev->dev, "SDMA received a doorbell from BIF with byte_enable
> !=0xff\n");
> +
> +	dev_err_ratelimited(adev->dev, "SDMA received a doorbell from BIF with
> byte_enable !=0xff\n");
>  	sdma_v4_0_print_iv_entry(adev, entry);
>  	return 0;
>  }
> @@ -2259,7 +2260,7 @@ static int sdma_v4_0_process_pool_timeout_irq(struct
> amdgpu_device *adev,
>  					      struct amdgpu_irq_src *source,
>  					      struct amdgpu_iv_entry *entry)
>  {
> -	dev_err(adev->dev,
> +	dev_err_ratelimited(adev->dev,
>  		"Polling register/memory timeout executing POLL_REG/MEM with finite
> timer\n");
>  	sdma_v4_0_print_iv_entry(adev, entry);
>  	return 0;
> @@ -2269,7 +2270,7 @@ static int sdma_v4_0_process_srbm_write_irq(struct
> amdgpu_device *adev,
>  					      struct amdgpu_irq_src *source,
>  					      struct amdgpu_iv_entry *entry)
>  {
> -	dev_err(adev->dev,
> +	dev_err_ratelimited(adev->dev,
>  		"SDMA gets an Register Write SRBM_WRITE command in non-privilege
> command buffer\n");
>  	sdma_v4_0_print_iv_entry(adev, entry);
>  	return 0;
> --
> 2.25.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.or
> g%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Ckent.russell%40amd.com%7C9c54e549a4de44a3ea5208d8ffd5
> 4f5e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637540638931742269%7CUn
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6Mn0%3D%7C1000&amp;sdata=gfJgrzcoO4XAWGWMoemobcpudQbhMrHkwHSW1o2s
> 58w%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
