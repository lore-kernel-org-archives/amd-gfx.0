Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE940C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 15:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6865D64EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 15:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6865D64EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7AF46EAD5;
	Wed, 24 Feb 2021 15:54:07 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5656D6EAD5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 15:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEWGXP/tbpdU+wtdzrCONYaubFViRh6EHswK9OX3y1Z07WPogrEJG4hAqzsyNYBVao+p/ApfFW5K3iBhGpIqOvpyn3rEQQZJ4fETCdrrCCjSbxU81oO8CdsnWl4O7Cjv93m4trPa5EPkWH5F3OdDlQ9zKXGsCtvssGCP7PqsPy/4IpHW8f7DH89uGN7L+VeLVeEkfrHVi1Mq+TlRo/z/kSSNbKZMdFBExXNxIgNWG3QNaQjS6uSWoDzN0jxTpedKOtS5J4SzESKY8vSWDEFNlcWPFK6ZBOdBLuHTyesf+VxdrrhvLA3S879gsOWZ+CsmXpCEqzPbKXIs+y0Hgt0wWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9NBmJOyfRyswVEwEX/NRrcjZ7LwgL2XFP2jKk8NogI=;
 b=Xw/SSr89VZyKEYeSVesOcK0xIFoJc9kiF794xhuVdJYkYa3B2TZZxBABZG3hgdsJU4GLFT4mN75RH084Jb9rPqUbHpauUxJ9X9yR6g/6CyffCIabkDUYeSD9EzCCt4pbgMVz7e5CC0kZm05tHhDOQDsIqpS+Ybz1GCaOpS0ZKyqu3iz0krJh3Z4W8asneMoDnS9WtXksJ4uen3VNj6klv1Lt1c+wg2qPKUHQBfhPKCVZDPLyChvYoVv8jIgelHhI0fhsChkIZvDxqszofCTVFyYQdHWAfUCWFLXnhNCa8SnsOP1n9R5W3hMU9yfatLctEDdKCUtDfqUdayQwrvQsIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9NBmJOyfRyswVEwEX/NRrcjZ7LwgL2XFP2jKk8NogI=;
 b=pIEDDjVZfjKcnH/ky8thfJWhD53A3n3EfVNWZA6OLssr3qmqqXk0V385v6OICZuSik3Nbu9dD4L+kDq2W+0iBZHKv5sJ512txCr0+LhIGnM6lT0NKSt0wSTWyndc6DsHppajgCIWf758alCtPeBUwV2Urk6Td4OxDTQZO16KNSg=
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.30; Wed, 24 Feb 2021 15:54:05 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::b193:3bb1:c6d8:aeec]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::b193:3bb1:c6d8:aeec%3]) with mapi id 15.20.3890.019; Wed, 24 Feb 2021
 15:54:05 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add ih call to process until checkpoint
Thread-Topic: [PATCH] drm/amdgpu: add ih call to process until checkpoint
Thread-Index: AQHXCihgUFM1lTWv+0y8BVaUPm9YeqpnBy0AgABpVSA=
Date: Wed, 24 Feb 2021 15:54:05 +0000
Message-ID: <DM5PR12MB4680F60D6590680E40A90AF5859F9@DM5PR12MB4680.namprd12.prod.outlook.com>
References: <20210223211026.116403-1-jonathan.kim@amd.com>
 <6d30f52e-7a7a-5662-a66f-db832b8386ae@amd.com>
In-Reply-To: <6d30f52e-7a7a-5662-a66f-db832b8386ae@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f24c941f-3f69-4067-a684-5d21a67771d3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-24T15:33:34Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:7a2:ec00:d1e8:41e1:b8e1:a873]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b910031-e286-4ed8-ae05-08d8d8dc69f7
x-ms-traffictypediagnostic: DM6PR12MB4433:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4433D015CD5996F41400571A859F9@DM6PR12MB4433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HsNPAJNkur23A3WMZ8QLeo3ch6qEGH9Xl/9PcK/oqaNmx75eyxRZTAt1faWrVvWZJBV32vhCWyKgb/tUzbWJ5hptas0ykgvr9o3G8W3rGb1UDFXteYVquEuZb4zBqJMt1vlWocbXD4qU+zg7NnH27K2/8Zr703XeyOe+BmuSGP7nWBDrMvtExMZzd7mNMwHP6vLCqH0+Xz5SPfEEhOktOVtcbuiG2DrWDbMqu9cGIsyABXt+cTrfwxO+yezKc6fknmSVHA+F3PoF2NebAEoJobXoNm3O4too9dhvZAwhr36R2tZFORTMba4oXAOEe8a1vILskPxwXTRMza2ws7vnVGu/Dn/7ON0knBlE0eGviIpTiv0RBk+npLEojGougg2bKckCiC1LtDTEyui4YUOCwwwKz1KQE46f785vrGHec61YORRClqW2E/CIYRmmlZ7Ib+RNgOy3N9khlHgCqBt9R+9amgEOC7wMIUMNJ44SVVlFMPSREqMnZ1D+CG2xxdMckhBEw4FFLFTxf51zdxMd6Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(2906002)(478600001)(6506007)(4326008)(316002)(7696005)(53546011)(186003)(9686003)(66946007)(66446008)(64756008)(66556008)(66476007)(33656002)(55016002)(76116006)(54906003)(110136005)(52536014)(8676002)(83380400001)(5660300002)(8936002)(71200400001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?U0RkUGIzWWFLMUNpOWhLYjFwdmFHTWJJc1g1eGlUTUpCUlB1RVJxODEyNmR1?=
 =?utf-8?B?NXo3QzFmU1puTDl0RHN2Qm9wMlYrQmpBVTUvMTRYcWNXUUJyU3NSZXU1akll?=
 =?utf-8?B?UnR2U2g5UHFQTVRISlhvcnZCZ3VPS3hIRzcwblhlV1RLZ1NzVlpkdjdMOFlj?=
 =?utf-8?B?b3dyaW1GSEFYNDZpWGxlSVp0YVNzdkNvY3Z4WHNudEw5eWYzbytqU2E5NFhN?=
 =?utf-8?B?NGpSQTdmVmYwTzMva0JkeUlvTXRlSDlhZ2FEaGVkWEo1VHNOay96SE1mS2lu?=
 =?utf-8?B?Yjc5SjAxV2NGaGI4L3hEbnB2T04veGw0S21MM29wSnJGbFloUWxSV0Yxb0dC?=
 =?utf-8?B?ZXVNVjF2dEFxeFI3RHVCZkE1dUZOcTRZd0kyVE9vczA1dlFaaDhyK3BzS3B5?=
 =?utf-8?B?alJUWHVqYytNUHp4Z0hXNlowcnJHMTR3ZkwwZm9JR3JNOTR4WGtSTnBabnJi?=
 =?utf-8?B?Qjc0SlIyZmRBTk81QXlDUXoyNWpBRWp6eEpZMU0xUEthRU1wa3UxNlhoUkdW?=
 =?utf-8?B?UnVyN2FVOFQxd2l0amt1Q0hvS3FzYndPbjVSNXFtMFRYRDVmT0RCQnl1R3JC?=
 =?utf-8?B?eXo1VytQSmVsQWxYdk9nMnlkUmpZWExLSmsxcHdXU1J4TjdCb2ZaMVQxYllP?=
 =?utf-8?B?WnVHUENob29kQVFDdzE2Vk9BWWtGWDYxRU9DQnNmM3dyMklOc3BLOXc5R1VS?=
 =?utf-8?B?NDNHWjNpNno1WGordzVTUDhrbXgrYkNKVHN3Y1k0YW5PRmNzOWJycHQwOWEx?=
 =?utf-8?B?OEZsdWU2a201QmJYeWlEN3ZvZUNnbS80YmwxZ2c0ZTIrRDJ0d0pqZUxzWlJC?=
 =?utf-8?B?cUlXQ3dUdzREUnlFTlBxOFY3MEo2dkZybDlhTllsODd4cXJlNDJxZTlpaUdP?=
 =?utf-8?B?Ukp6NVZCRzF4QzczTXlKazBpaHgwWjA0NVQzQVhjL3BrZGdFd3pOYlVqeURn?=
 =?utf-8?B?VGs1b2tNWEdLS1IrMU5pWG5Gbzk2V3pFVXNyOXVmenJuUUVVUHVXZWVxQ1dS?=
 =?utf-8?B?SEFLNnJEbkpqWmYvVHJBdFExV25iTm16eDRWSE80VkROM2FHTHRtd2dveXVt?=
 =?utf-8?B?cWlHOURPMUNFdVRpMFZuR1huQ3h2NGhFWDJtYzlhd1A2L3FGbW9UTWczbnJs?=
 =?utf-8?B?bXF4eFd2NHFjWXFmRlJJMDJMdXhSZ0crZjRWaW45amRJZlJXTGlpZ1BvU3Yx?=
 =?utf-8?B?U2FGQ3RGU01RNXd4WHdTL2Q3U3liQnZ2MXhtUHhIbmV4RWpGSzNKdzJxYWdY?=
 =?utf-8?B?UWRPN3ltT1p2TWxTajd4RUFOblh3YVdLMHo4RzQyRi83SkZEcXFnZ0xwZEZH?=
 =?utf-8?B?dXA0c3FLbFFKOG5yem5SKzhWeHNZZmJLY2NBQURtZXRrcXZ5ZEEwenUrcGhD?=
 =?utf-8?B?Mko1T0J3RW44Y1RYRjFFTGFsbmh1QnF4YVA0a0dzLzhsZVBrazBJSnU0Qk5k?=
 =?utf-8?B?TXIvbmJSNXhORndFdGtqKzZ1WDdPMmtaTDZzRUM1ZHIvdDdzN0RxNGovV1Vr?=
 =?utf-8?B?azBobzE5YVZndmNXNmtjaVFjRUQvOGxYQ1BZSEljVis4L0p1QWNuWmdlWmJ1?=
 =?utf-8?B?S3JGL3RLbEoxZGszM012SU8zcVRHVFlmeGlORkc3UUpXdWp5WFp1K3hIQTFu?=
 =?utf-8?B?cXNKTHBjakxUM3AwRUlzUm52YWlwa3FMb1ZINzVVeXlqYjVLWmp0dXhOaVNW?=
 =?utf-8?B?bWJHSllUcWxMWGdmQ0E2SFVvOFE3VDNDZ2FENE5oem5YRFJxWkZ3R3hJK3V3?=
 =?utf-8?B?RklxMXdZQ1ppMGc4bDBHcjNNdndIODJTelVtMTdQcXVxYklHM0NZaEZHZGQ4?=
 =?utf-8?B?b1g3NnFGaThPVVVRZncvaGo4V1dabTU3N2tIdDhFMVNJbWVOTFF1ckFXRTdh?=
 =?utf-8?Q?wBtdm7yRjvDde?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b910031-e286-4ed8-ae05-08d8d8dc69f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 15:54:05.3900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OA7z7WdU1mTFuNzXfci3QA/0GUwVPg1JTITCcOvgx4iYhcbDWzNaM2VzoSBh5Hog
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, February 24, 2021 4:17 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: add ih call to process until checkpoint
>
> Am 23.02.21 um 22:10 schrieb Jonathan Kim:
> > Add IH function to allow caller to process ring entries until the
> > checkpoint write pointer.
>
> This needs a better description of what this will be used for.

Felix or Philip could elaborate better for HMM needs.
Debugging tools requires this but it's in experimental mode at the moment so probably not the best place to describe here.

>
> >
> > Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
> > Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 46
> +++++++++++++++++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  2 ++
> >   2 files changed, 47 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> > index dc852af4f3b7..cae50af9559d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> > @@ -22,7 +22,7 @@
> >    */
> >
> >   #include <linux/dma-mapping.h>
> > -
> > +#include <linux/processor.h>
> >   #include "amdgpu.h"
> >   #include "amdgpu_ih.h"
> >
> > @@ -160,6 +160,50 @@ void amdgpu_ih_ring_write(struct
> amdgpu_ih_ring *ih, const uint32_t *iv,
> >   }
> >   }
> >
> > +/**
> > + * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to
> > +checkpoint
> > + *
> > + * @adev: amdgpu_device pointer
> > + * @ih: ih ring to process
> > + *
> > + * Used to ensure ring has processed IVs up to the checkpoint write
> pointer.
> > + */
> > +int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device
> *adev,
> > +struct amdgpu_ih_ring *ih)
> > +{
> > +u32 prev_rptr, cur_rptr, checkpoint_wptr;
> > +
> > +if (!ih->enabled || adev->shutdown)
> > +return -ENODEV;
> > +
> > +cur_rptr = READ_ONCE(ih->rptr);
> > +/* Order read of current rptr with checktpoint wptr. */
> > +mb();
> > +checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> > +
> > +/* allow rptr to wrap around  */
> > +if (cur_rptr > checkpoint_wptr) {
> > +spin_begin();
> > +do {
> > +spin_cpu_relax();
> > +prev_rptr = cur_rptr;
> > +cur_rptr = READ_ONCE(ih->rptr);
> > +} while (cur_rptr >= prev_rptr);
> > +spin_end();
>
> That's a certain NAK since it busy waits for IH processing. We need some
> event to trigger here.

The function is meant to be just a waiter up to the checkpoint.
There's a need to guarantee that "stale" interrupts have been processed on check before doing other stuff after call.
The description could be improved to clarify that.

Would busy waiting only on a locked ring help?  I assume an unlocked ring means nothing to process so no need to wait and we can exit early.  Or is it better to just to process the entries up to the checkpoint (maybe adjust amdgpu_ih_process for this need like adding a bool arg to skip restart or something)?

Thanks,

Jon

>
> > +}
> > +
> > +/* wait for rptr to catch up to or pass checkpoint. */
> > +spin_begin();
> > +do {
> > +spin_cpu_relax();
> > +prev_rptr = cur_rptr;
> > +cur_rptr = READ_ONCE(ih->rptr);
> > +} while (cur_rptr >= prev_rptr && cur_rptr < checkpoint_wptr);
>
> Same of course here.
>
> Christian.
>
> > +spin_end();
> > +
> > +return 0;
> > +}
> > +
> >   /**
> >    * amdgpu_ih_process - interrupt handler
> >    *
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> > index 6ed4a85fc7c3..6817f0a812d2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> > @@ -87,6 +87,8 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev,
> struct amdgpu_ih_ring *ih,
> >   void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct
> amdgpu_ih_ring *ih);
> >   void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
> >     unsigned int num_dw);
> > +int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device
> *adev,
> > +struct amdgpu_ih_ring *ih);
> >   int amdgpu_ih_process(struct amdgpu_device *adev, struct
> amdgpu_ih_ring *ih);
> >   void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
> >   struct amdgpu_ih_ring *ih,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
