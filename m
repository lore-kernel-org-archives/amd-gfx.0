Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4532AC33CA9
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 03:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1AD2080D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 03:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hhECOXtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1AD2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 906306E1D8;
	Tue, 14 Jan 2020 03:08:22 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680048.outbound.protection.outlook.com [40.107.68.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58ECF6E1D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 03:08:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDnsD08X9B5IGpQRJRtSWkowHbPTBLhq8uFQSl13ewimSCupNYUk5sRuLM9LopHqhqz2ziz4WdS2aXsJM1ETWCcAVmle/+I4FDCmPkUz0gYosCbOS/Rlbmk1+yUp3fghMNdT5vaL4wTNgRLWSM+4pNcPeVyuUqaGR8692fOuBZos0ZF7gQPly2LHl6vwBylHYt7sbTRPAy25vLgueev5KFYBH8D8dBB7nmJggSuednfgqFsNe0l+J/wjz0rmzTbweqwq7P1QTICZYuFPrdz/XijXdWNc3WHfHFfqc7KZDyUR3kw5AxCFYuENtcIXclAZFB0qjh7qz+9SncwLF6+3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIaUvu8EVXM85KJVt9uMA5GoK8pYkOV4akTuFN8mflY=;
 b=fHyeFXdm1TUpm3S2dsnfN8QS+q0omAEr6UyribCXlxcp8m4ykBEIbLf9mpDEGVXGrDAQQLtj0yJrEzEhSf8W6DnYx+emUXLMXYBjjcKCzY1IIKO0QAWwTFvHBid3jnpOb8OV2FjtV6GjvAQbD+HMuU022JB2Sonz76DsZy3HHJtlefgKYtcIXP8pkR7BLCAMUY+50mM6VDABeMghdJXAICImzhmiXO6Bn3UYmYX+ZkGtVweqxG+GniLrmK6QrmQtsN7HGoZcg31iG2mpUpBLfuD3ULRGXmV2QcZdfHqZ+oVzKOjzT1ppFokuKnbl4oj7vyMyLd69qNZVjNV1IIYTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIaUvu8EVXM85KJVt9uMA5GoK8pYkOV4akTuFN8mflY=;
 b=hhECOXtHwfbK+ghb/83hyh+9WZdcpYLEB97fZn7nFlllwLg7dBxeIFlmK22iJIG8feOtCLiV9cDeWPI55P9sPrGlUyL92eXwQULIG2rkSlAYsarMKOGDE/m1WEDcPXhWlTrtvEAqyCVWXWOEDXJ+v1ZB2Wg4UQyWSMFfOPK98BI=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB2485.namprd12.prod.outlook.com (52.132.208.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.16; Tue, 14 Jan 2020 03:08:18 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 03:08:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: check rlc_g firmware pointer is valid before
 using it
Thread-Topic: [PATCH] drm/amdgpu: check rlc_g firmware pointer is valid before
 using it
Thread-Index: AQHVx+SFZJJyS5fRwUuiU9Hhp6T2n6foytsAgAC1AbA=
Date: Tue, 14 Jan 2020 03:08:18 +0000
Message-ID: <DM5PR12MB1418E0E86A8F27DB4CC31601FC340@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1578681221-11093-1-git-send-email-shaoyun.liu@amd.com>
 <977f2a89-9595-2ec3-f8f8-ceb3f7375983@amd.com>
In-Reply-To: <977f2a89-9595-2ec3-f8f8-ceb3f7375983@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-14T03:08:15Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=408208a4-9cb6-4382-afa3-00007f666475;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-14T03:08:15Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f5f0ef80-64d2-47dc-9028-0000d0e8e5d3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [223.104.212.167]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53aafb9d-0028-4bc5-a801-08d7989f0132
x-ms-traffictypediagnostic: DM5PR12MB2485:|DM5PR12MB2485:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB248599130D164DEF3AFDAD99FC340@DM5PR12MB2485.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(189003)(199004)(8676002)(81156014)(8936002)(81166006)(33656002)(2906002)(186003)(52536014)(45080400002)(64756008)(5660300002)(66446008)(66946007)(76116006)(6506007)(66556008)(71200400001)(966005)(86362001)(316002)(53546011)(110136005)(26005)(7696005)(55016002)(478600001)(9686003)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2485;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lcwQFLSrAPkTSaxJo3pGxD5TR3YLIvbD1tP0mNqaCd76GDx8X12iROxRNp1vOiIEsM5BBMUI+PVVl6SqGbvyA2g8vFAkzYgyGRruNPdjbKOPDYzY1Sa7lQKnVhKP3GtbRjT7IUnM3HzF4pMv5AKKaonmC33RjsrRRVmK1NO8vbGViU/0G5lzbgrNNrYonRaoynQbSbTdAjXrcgC4Z0lyJF6Qvab1IyMRpCIVCwlwLyDFw/T8ww9nTx7j1RoeGywIN867juk7g1B9p133L5q3A9pVhS3Wr1DmlxKfjYB7kiJUOvwmtNDF0NQ/r+TCJKv7td6ZCkqLAnaREb5JKguuthdkbYEn5jQIhtScXQG8mhqWMvDCnY6A7xB5NdNvzqngkoYuffdbZTwvme9E+rQ+OcKrLS0lznQ/DawsbKEArrgzCSkU3kAvpdSIh0Zz4TmwNjGWjUwpgvmHJfDAG6rnZCDTIyqSz+adktuHar695vc=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53aafb9d-0028-4bc5-a801-08d7989f0132
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 03:08:18.2963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JL5Jy8lBAFq6U0GR5JrOxuIMdMqbC8+7723CV8wXCIfmalD3CbY27HlhkeTmb7BIVyncTZwGkv2b499p8t1U/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of shaoyunl
Sent: Tuesday, January 14, 2020 00:20
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: check rlc_g firmware pointer is valid before using it

ping.


On 2020-01-10 1:33 p.m., shaoyunl wrote:
> In SRIOV, rlc_g firmware is loaded by host, guest driver won't load it 
> which will cause the rlc_fw pointer is null
>
> Change-Id: Id16f65171dd427d623af4c5bc75f674019e63dec
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 379e46c..07e22f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -808,10 +808,11 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
>   		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_G];
>   		info->ucode_id = AMDGPU_UCODE_ID_RLC_G;
>   		info->fw = adev->gfx.rlc_fw;
> -		header = (const struct common_firmware_header *)info->fw->data;
> -		adev->firmware.fw_size +=
> -			ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
> -
> +		if (info->fw) {
> +			header = (const struct common_firmware_header *)info->fw->data;
> +			adev->firmware.fw_size +=
> +				ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
> +		}
>   		if (adev->gfx.rlc.is_rlc_v2_1 &&
>   		    adev->gfx.rlc.save_restore_list_cntl_size_bytes &&
>   		    adev->gfx.rlc.save_restore_list_gpm_size_bytes &&
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C07f331f5dcd34309309608d798447956%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637145292188230052&amp;sdata=CgDYPwyn688ERtFq3ldST2nMMejq1a1RxdDRAjKK9jc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
