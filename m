Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646E5EB64DB
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 07:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA93510E280;
	Tue, 20 Jun 2023 07:57:45 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC86D10E280
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 07:57:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ys9IlNJPNSqiYSgmHXEk8yJ0z/en401zm1zm/A7LbyH6Keluyyw5baldjQQS+V/J6/HQiy5phOE8+UcdLW3mk5/ydoeXGfc26rs6i+tTUQPQidHcHQEU7D/7D7gEKlKMtD1TETN7o04sKV3haS3nYjYOzlIl9RZ7knwV7QLuKkj8hsoSMrMjUkICUIOkEJiKsBhCmNsBvmkGBOWV/Apvgn5BbIChkN60bmUQ9Kk3q0C9hsyhX0dQXGvNZGw3ARXjebHWVQ5499HJZ6mHt1J5eXMZAd/quY6L66r/CYhNGRuVTgj9CIQU16HjnWOKvuWVwreJ2C5LzzhLltlvrb8DTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGelzgOJW00iWdrsG8bLNYh89dKiHs7h+rgSzqnAzDA=;
 b=erMc/sqv5XrosHZbb1uuhtNGhblPZOyABT8KqhTBDzNkWXCUQsGoRM+FxzsH6KAD7Y432+oPEzzbsMEmZd1neTcaOr7JTchITZoCqKpwSf0+ULz2SNAkyKck6E7ulOI6xq6EJQARAax7jzDjBrCoBbWMO2NOy1H2noSJCori87NvjIBvBNALCcc7RZLO0zW2Zk8rFEawGAz7mF/mLUCgC8RvNbBR2a1AT0NHwpc7MDYvR/tHeDJU9yxnZE+d716RjtQsgZjg4EE9bk4/a5gl4eQouB/9WDQBgJglhDIQmnFrEWKOkwctDQaBd5Fr1Jn0NMs+baYW6ytAJAUmuhfR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGelzgOJW00iWdrsG8bLNYh89dKiHs7h+rgSzqnAzDA=;
 b=Wvdlzo5cSz8XjMf3laG83IZb8JVHCdnHMMlhw4uSrzPK+tRUqIGO5W/6HhkaGntm04PtJ75YdFF3+X+NttConDozHMOTpF1lY+1se/7n37GvNgkgTh0oJsVEeFAW2yDb0XDfsDenrayk4RCcS97b4qzhiAQM/HadBc1MwnwFjRY=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CH0PR12MB5092.namprd12.prod.outlook.com (2603:10b6:610:bf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 07:57:41 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::b918:c914:98d9:2975]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::b918:c914:98d9:2975%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 07:57:40 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH Review V2 1/1] drm/amdgpu: Remove redundant poison
 consumption handler function
Thread-Topic: [PATCH Review V2 1/1] drm/amdgpu: Remove redundant poison
 consumption handler function
Thread-Index: AQHZorTwMKAj8ByipkmnjnNw+259c6+TUt8g
Date: Tue, 20 Jun 2023 07:57:40 +0000
Message-ID: <PH7PR12MB8796C95756C75A3711B5B309B05CA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20230619134953.180252-1-Stanley.Yang@amd.com>
In-Reply-To: <20230619134953.180252-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bb0c9f63-183f-417b-a302-73613cc11eb6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-20T07:52:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CH0PR12MB5092:EE_
x-ms-office365-filtering-correlation-id: cb611015-a5db-477f-a1f1-08db7164053b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cc1kVMy3aYJ44dsQZafOuJsRq8xIT6c7FtH8/eBkhapJQdiAJdxTpvAyQKBKizTZ9X0M0UvhBq1fUydIJ0Gm5ZJ2WiMU8DdMYMvVxs2I0fY9sIyRZ21zSrYfe418bV2SSRVxJqVMRE+6gNWKEH1fW1rHspEpqjevb3PPX2WonPUM59ZUKqNpkt2g+UKcyS1Tsd8S8UBstinggwU+eCk9001YiX4hr8YaTUwzm0L7MjmKHhumwPC+fZGab3FwlhClb/22Vgoj0tXXxJZLznUhubhNyBairBSnUiKEWFL0iVdYgY5/XsX+u+hrQbFfHSPtnk9FcCqH9hsssMI/tvyDcYSLUncmZO71ifenhJOc3mjFpXuTodFC+p2PMahhs/hKPbQQmEPttkThU1W4md1goQTeiTQWZ1vOUKpw1VwX91/bq/O2+aIlCJXOZjXq1vrCsTRNHDxLmXiBA0es5ZeYwHZ2R2ygrEHxefRlAZA1/pJZAAvkMRU3Xt3cTHD+GOdKrNdhAaihHnlihZzwqdNL7Qg8CxnpNg1WOU3EIdW+Ww3ZJ8KZ40mxNh1W4mDIx8NCZBxgkn3uNTat6IIh1kCvnse4x7dLgnOdI4iVKHXBa7MHNhPgiYQa3mmpOCgAxI48u2vGwfDr9Crt3lLKSVq/ow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(478600001)(2906002)(7696005)(55016003)(86362001)(110136005)(33656002)(71200400001)(122000001)(38070700005)(26005)(186003)(6506007)(9686003)(8676002)(8936002)(66446008)(66476007)(76116006)(66556008)(64756008)(66946007)(53546011)(5660300002)(6636002)(38100700002)(316002)(52536014)(4326008)(83380400001)(41300700001)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pssm/qfys8Q5W/OAO2LCQcuQq9RGzB4rpGY2NXyPt2knMc3tY7kFjA8AQ0gc?=
 =?us-ascii?Q?Sog+ocQLvno9a4uCJAiIFor8YDD7yNEOQmy0VmfvlS2c+MtZeb0Sh3srTYWi?=
 =?us-ascii?Q?hx6EYxfw4L79KM+TtkM6vZzi/8Bk1FeueKEX7o8LUOKmbF9V9Yp9CBElhl1I?=
 =?us-ascii?Q?s4usOMtpG2eV12M2ckusqJnDdE6C0EoV1hFYgfhRjgSBazIZibQEWsFkF/X1?=
 =?us-ascii?Q?hiEiAviJoIq6jis4Qj0PV84/jjHVU31UVvi432XdoY4DTavtAqxeWt8oKMLI?=
 =?us-ascii?Q?0nhrsETVRcgHkeHXwNGd1OfawcYANUI+TsyZ3tt+Tha7nocnH3uEXfmvOFtR?=
 =?us-ascii?Q?o7Bdxx/iICDXg9mrAiQMymRgfSbcy2lOwDLMMkRbm/U45claMw/O80B8xJlR?=
 =?us-ascii?Q?/OSkFiWXwl63qyiv8u43rm0pITgkDqdNLOFDPV26aldpMRt25xaqRSFoGi6e?=
 =?us-ascii?Q?hw2hMP2rQzsTLeZrSEgjvgXydHMvdn1azFbm0b8JETF0IOfdxxgb7uG92grH?=
 =?us-ascii?Q?M/BlawONDMQKBCWBcpXvPLz5BpZssmYkCY5dCtBEipQuvyvln1/hUcyTcPEM?=
 =?us-ascii?Q?cIROuRSElSpX9kctmPi0eVEJ4vlrZxg3QrlJDMdcBGgO/gHXfuEAVNPD0Hhn?=
 =?us-ascii?Q?aCM/WwBZAnmaMffQN+rfpIXs5NKgC3of1t9K/qY5OhpbfuAw4PTBeUTV5zKS?=
 =?us-ascii?Q?y1d8Jeb60rrkOPmVYGKExKPmVlM75pOyXbVcAgrcuOcZJSCbih8qMIb9zfR8?=
 =?us-ascii?Q?h6NoZUkOP57iQJp2Z9cJduOT1DJPwazBrgg2nWJ0TOQqhO6gLou1D9WE71Bk?=
 =?us-ascii?Q?ur1F+MpHSQtGX+ZwvYjlqL6OeP5qJ6JY1lWiKo8SLnrobvngE3j2slvemh4B?=
 =?us-ascii?Q?sVRXVppLyQp89f1lRprdpNCcKXm/iFnsvY6PJ5/TdXL5yQlHakUJQLtmG3u5?=
 =?us-ascii?Q?D8JNtF57nFarRenQITfrO8c+EfBCBJURFzOoXkXisurtNmrQ3HZBwjhawOxc?=
 =?us-ascii?Q?+samu9DKSBIEFQtpq3vG9KiPpxEDCaTYuvlwR+uLM87+Ao2lmUYKgjZ9Hgiv?=
 =?us-ascii?Q?mdPrka1bw1o901Q/taEJuACMU5WmfyVgVmdAn1P6bINtMM68ZWOAd2ulFyCX?=
 =?us-ascii?Q?rpDCT4HJ7zVG0A74e3k+XhjekIkGTubXYMgTEirVy4unZ2uMUr0klziImkUn?=
 =?us-ascii?Q?IPW/9eri5mtYDcA4WcyrWRH4EUHPtWmi7D+cl0wfHxeY0DyhhoVwqIpo2SSr?=
 =?us-ascii?Q?aUWuI3Y5gpdT3QphLjX14WFnH3uB1o+RoCmUqY5ua3EHcCBKIOB/tpdqBGNR?=
 =?us-ascii?Q?3+2nwD6b/q8NT9xM8KZe1hKncEsyxH1MJF8DSSOmw9HVbT4DJQbJ0V8uLm2l?=
 =?us-ascii?Q?+MreGlhx0fnjOeSouMrC0hYg7LtWhE+thdpqMjBWBATlniDgmG5EKuTYn+h7?=
 =?us-ascii?Q?si85YZQ4Im44O1+GkW1Oc5OvghiqZV+/bO30KFiCZZ7Cq/S+lSMONxXVgvLi?=
 =?us-ascii?Q?mRFPg+MXVU6Z6/R1QUKmqET0bsDZ65p1qXg/AzWAy/erNUwD7OqlTOwi9Lsr?=
 =?us-ascii?Q?46QKrYlm2QSqRQwTnnw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb611015-a5db-477f-a1f1-08db7164053b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 07:57:40.1246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ff5WUVzLqrydEDJB9ievTm9FVh6LLtmtY/r1j2WKB+UyeQSBJ1ij6F0YGUSyWCtU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5092
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Monday, June 19, 2023 9:50 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>=
;
> Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review V2 1/1] drm/amdgpu: Remove redundant poison
> consumption handler function
>
> The function callback handle_poison_consumption and callback function
> poison_consumption_handler are almost same to handle poison consumption,
> remove poison_consumption_handler.
>
> Changed from V1:
>       Add handle poison consumption function for VCN2.6, VCN4.0,
>       JPEG2.6 and JPEG4.0, return false when handle VCN/JPEGP poison
>       consumption.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  9 ---------
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  4 ----
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  8 +++-----
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  |  3 ++-
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c | 12 +++++++++---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  9 +++++++++
>  9 files changed, 50 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index a33d4bc34cee..c15dbdb2e0f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -840,15 +840,6 @@ int amdgpu_gfx_ras_sw_init(struct amdgpu_device
> *adev)
>       return 0;
>  }
>
> -int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
> -                                             struct amdgpu_iv_entry *ent=
ry)
> -{
> -     if (adev->gfx.ras && adev->gfx.ras->poison_consumption_handler)
> -             return adev->gfx.ras->poison_consumption_handler(adev,
> entry);
> -
> -     return 0;
> -}
> -
>  int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
>               void *err_data,
>               struct amdgpu_iv_entry *entry)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index d0c3f2955821..95b80bc8cdb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -273,8 +273,6 @@ struct amdgpu_gfx_ras {
>       int (*rlc_gc_fed_irq)(struct amdgpu_device *adev,
>                               struct amdgpu_irq_src *source,
>                               struct amdgpu_iv_entry *entry);
> -     int (*poison_consumption_handler)(struct amdgpu_device *adev,
> -                                             struct amdgpu_iv_entry
> *entry);
>  };
>
>  struct amdgpu_gfx_shadow_info {
> @@ -538,8 +536,6 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device
> *adev);  void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev,
> uint32_t ucode_id);
>
>  int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev); -int
> amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
> -                                             struct amdgpu_iv_entry
> *entry);
>
>  bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);  =
int
> amdgpu_gfx_sysfs_init(struct amdgpu_device *adev); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 5b6525d8dace..9ce7c7537751 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1668,7 +1668,7 @@ void amdgpu_ras_interrupt_fatal_error_handler(struc=
t
> amdgpu_device *adev)  static void
> amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *obj,
>                               struct amdgpu_iv_entry *entry)
>  {
> -     bool poison_stat =3D false;
> +     bool poison_stat =3D true;
>       struct amdgpu_device *adev =3D obj->adev;
>       struct amdgpu_ras_block_object *block_obj =3D
>               amdgpu_ras_get_ras_block(adev, obj->head.block, 0); @@ -
> 1694,15 +1694,13 @@ static void
> amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
>       amdgpu_umc_poison_handler(adev, false);
>
>       if (block_obj->hw_ops && block_obj->hw_ops-
> >handle_poison_consumption)
> -             poison_stat =3D block_obj->hw_ops-
> >handle_poison_consumption(adev);
> +             poison_stat =3D block_obj->hw_ops-
> >handle_poison_consumption(adev,
> +entry);

[Tao] !block_obj->hw_ops->handle_poison_consumption is allowed, we can add =
the following code to avoid adding handle_poison_consumption for vcn and jp=
eg.

else
       poison_stat =3D false;

For the change in GFX, it's better for Thomas to take a look.

>
>       /* gpu reset is fallback for failed and default cases */
> -     if (poison_stat) {
> +     if (poison_stat !=3D true) {
>               dev_info(adev->dev, "GPU reset for %s RAS poison consumptio=
n
> is issued!\n",
>                               block_obj->ras_comm.name);
>               amdgpu_ras_reset_gpu(adev);
> -     } else {
> -             amdgpu_gfx_poison_consumption_handler(adev, entry);
>       }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 46bf1889a9d7..03f3b3774b85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -564,7 +564,8 @@ struct amdgpu_ras_block_hw_ops {
>       void (*reset_ras_error_count)(struct amdgpu_device *adev);
>       void (*reset_ras_error_status)(struct amdgpu_device *adev);
>       bool (*query_poison_status)(struct amdgpu_device *adev);
> -     bool (*handle_poison_consumption)(struct amdgpu_device *adev);
> +     bool (*handle_poison_consumption)(struct amdgpu_device *adev,
> +                     struct amdgpu_iv_entry *entry);
>  };
>
>  /* work flow
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
> index 26d6286d86c9..5b7eac547a05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
> @@ -78,7 +78,7 @@ static int gfx_v11_0_3_rlc_gc_fed_irq(struct
> amdgpu_device *adev,
>       return 0;
>  }
>
> -static int gfx_v11_0_3_poison_consumption_handler(struct amdgpu_device
> *adev,
> +static bool gfx_v11_0_3_handle_poison_consumption(struct amdgpu_device
> +*adev,
>                                       struct amdgpu_iv_entry *entry)
>  {
>       /* Workaround: when vmid and pasid are both zero, trigger gpu reset=
 in
> KGD. */ @@ -99,10 +99,16 @@ static int
> gfx_v11_0_3_poison_consumption_handler(struct amdgpu_device *adev,
>               amdgpu_ras_reset_gpu(adev);
>       }
>
> -     return 0;
> +     return true;
>  }
>
> +struct amdgpu_ras_block_hw_ops gfx_v11_0_3_ras_ops =3D {
> +     .handle_poison_consumption =3D
> gfx_v11_0_3_handle_poison_consumption,
> +};
> +
>  struct amdgpu_gfx_ras gfx_v11_0_3_ras =3D {
> +     .ras_block =3D {
> +             .hw_ops =3D &gfx_v11_0_3_ras_ops,
> +     },
>       .rlc_gc_fed_irq =3D gfx_v11_0_3_rlc_gc_fed_irq,
> -     .poison_consumption_handler =3D
> gfx_v11_0_3_poison_consumption_handler,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index aadb74de52bc..3d60610a9c70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -809,8 +809,17 @@ static bool jpeg_v2_6_query_ras_poison_status(struct
> amdgpu_device *adev)
>       return !!poison_stat;
>  }
>
> +static bool jpeg_v2_6_handle_poison_consumption(struct amdgpu_device
> *adev,
> +                                             struct amdgpu_iv_entry *ent=
ry)
> +{
> +     /* TODO: reset IP engine instead of reset GPU */
> +
> +     return false;
> +}
> +
>  const struct amdgpu_ras_block_hw_ops jpeg_v2_6_ras_hw_ops =3D {
>       .query_poison_status =3D jpeg_v2_6_query_ras_poison_status,
> +     .handle_poison_consumption =3D jpeg_v2_6_handle_poison_consumption,
>  };
>
>  static struct amdgpu_jpeg_ras jpeg_v2_6_ras =3D { diff --git
> a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index a707d407fbd0..328e3de14e35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -818,8 +818,17 @@ static bool jpeg_v4_0_query_ras_poison_status(struct
> amdgpu_device *adev)
>       return !!poison_stat;
>  }
>
> +static bool jpeg_v4_0_handle_poison_consumption(struct amdgpu_device
> *adev,
> +                                             struct amdgpu_iv_entry *ent=
ry)
> +{
> +     /* TODO: reset IP engine instead of reset GPU */
> +
> +     return false;
> +}
> +
>  const struct amdgpu_ras_block_hw_ops jpeg_v4_0_ras_hw_ops =3D {
>       .query_poison_status =3D jpeg_v4_0_query_ras_poison_status,
> +     .handle_poison_consumption =3D jpeg_v4_0_handle_poison_consumption,
>  };
>
>  static struct amdgpu_jpeg_ras jpeg_v4_0_ras =3D { diff --git
> a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index bb1875f926f1..e6dbea441caa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1974,8 +1974,17 @@ static bool vcn_v2_6_query_poison_status(struct
> amdgpu_device *adev)
>       return !!poison_stat;
>  }
>
> +static bool vcn_v2_6_handle_poison_consumption(struct amdgpu_device *ade=
v,
> +                                             struct amdgpu_iv_entry *ent=
ry)
> +{
> +     /* TODO: reset IP engine instead of reset GPU */
> +
> +     return false;
> +}
> +
>  const struct amdgpu_ras_block_hw_ops vcn_v2_6_ras_hw_ops =3D {
>       .query_poison_status =3D vcn_v2_6_query_poison_status,
> +     .handle_poison_consumption =3D vcn_v2_6_handle_poison_consumption,
>  };
>
>  static struct amdgpu_vcn_ras vcn_v2_6_ras =3D { diff --git
> a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index b48bb5212488..eb8625a6df92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -2134,8 +2134,17 @@ static bool vcn_v4_0_query_ras_poison_status(struc=
t
> amdgpu_device *adev)
>       return !!poison_stat;
>  }
>
> +static bool vcn_v4_0_handle_poison_consumption(struct amdgpu_device *ade=
v,
> +                                             struct amdgpu_iv_entry *ent=
ry)
> +{
> +     /* TODO: reset IP engine instead of reset GPU */
> +
> +     return false;
> +}
> +
>  const struct amdgpu_ras_block_hw_ops vcn_v4_0_ras_hw_ops =3D {
>       .query_poison_status =3D vcn_v4_0_query_ras_poison_status,
> +     .handle_poison_consumption =3D vcn_v4_0_handle_poison_consumption,
>  };
>
>  static struct amdgpu_vcn_ras vcn_v4_0_ras =3D {
> --
> 2.25.1

