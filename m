Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116F7C2BA17
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 15:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7945248DC
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 15:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tcJo6gfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7945248DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA3F6E439;
	Mon,  6 Apr 2020 15:53:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D906E44C
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 15:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eD1xKzOYSRtkHNmu+73ZObXAqTYkI9w+kZSum6aEyy/+Wuzn0MGJJvihu9gIFcogerO09nliTdUyy6qbruxAdZROjZr65b93pFjM2U+y6jnsYq3b2rTDEpFJ/fVEw/zJr4FtfoWqLAg7VbH2WjwXCBr3wKB3AC5JtLQYBdKrOTpPCJ/+36gkCDq7CZk25oXqhZNDlDfLwNmwI0y8YiKgFnCw7eI8KYU+efh2H4mqybnUVchunpu08Sc/Q976LR/FXCKuFdci6SBjeBUUWyDX1n7qUL5862QGVT/x/vlBR2hx2waRxnaHEv0q7WOpVnFSg8frVF+0LP2lB19nrgZHSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4wyoEasQZlBQGFBoSxClWqY9iL6cysJ7Fb9dkdCtQ4=;
 b=BViwxH4lOWFdEB8rfcCFyQcjNJJsDxhz5FKCy7MJmmwRCOm116iaz4GqDb3dCYw1CSBP4DmApGsxXipPtIAdEFzjzAM2EhpzCAhg80byHmfsIWIdFhHRymSs0+29jE52FhK7ApE25aIkmFhO+WI2+VHiVnqlTyPdIMi/lCaqzB+MuKXiEJN4fmF9Jad3hilISiztM5QnAk8d4zbmCCak+N76CPpT4beqdaDopZikZTT85+9AZreGF9G00WdlO8TtiRH6DUMiOxwy42p/1YH3kjTxwfQRY3eTb1uSoKXC45619nA+rbMlmBCR/qEQDNpDGpipOBfaXkIjekWHKr3INQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4wyoEasQZlBQGFBoSxClWqY9iL6cysJ7Fb9dkdCtQ4=;
 b=tcJo6gfWpy/3DBKaULTKdGHrTDgt+wgTdt0Z395SR1+h3ZK9o2m5T2ylECvMW3K0pM46IH58reF09r/jIwpHQcYH0YlQQrftnsDpczuDIKx9WtL4UNDykCyRjppNrgcbjhsk4R8UdjR3VJJl3pSs/1p04N7b6V+BclwRBxK7k6I=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Mon, 6 Apr
 2020 15:53:29 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 15:53:29 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Re-enable FRU check for most models v4
Thread-Topic: [PATCH] drm/amdgpu: Re-enable FRU check for most models v4
Thread-Index: AQHWDCs2uEXYnN1/J0utY8pDEk6WqKhsPpQw
Date: Mon, 6 Apr 2020 15:53:29 +0000
Message-ID: <DM6PR12MB3721B59E1D39ECE86BB4108185C20@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200406155108.16505-1-kent.russell@amd.com>
In-Reply-To: <20200406155108.16505-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-06T15:53:27Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=00399555-2fc5-4162-8540-00001177fa40;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-06T15:53:27Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: fb1bdd25-5b21-4ab2-aeae-000048a374c9
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
x-originating-ip: [2607:fea8:1c80:c44:89d3:2a74:6d44:185a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb6fdc58-e251-4ed5-38c6-08d7da42a6e8
x-ms-traffictypediagnostic: DM6PR12MB2682:
x-microsoft-antispam-prvs: <DM6PR12MB2682A2AF3F44B22FA3EB1EA285C20@DM6PR12MB2682.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:327;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(81156014)(53546011)(6506007)(478600001)(86362001)(8676002)(7696005)(81166006)(316002)(2906002)(8936002)(33656002)(76116006)(186003)(66946007)(9686003)(6916009)(66556008)(66476007)(5660300002)(66446008)(64756008)(52536014)(55016002)(71200400001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 63ZLfCsML4j8lMPkNsui5KXcXK3BIc/X9Q2c/XtGQFzj+lDM9xOeGraMFd0sTk4dYCa/Z7LH7yGsjrvsvi3U5mYgUeUGS1dmtbhcIkCb4T6XJviMKkHKIowLL/zSK8qBrKHX7mEuOrjWXY30CeKDmB3BUB1u5bGNd/4Sjs7nZApg5ssJ6+KgbMiYzbglFlZSsBh025oTrloIAj7Y7VC2SMf+hC4svBlcK4AYdomp7TJ3++pU95i5rAf1fa0cgZLitb8TxeQnoB1M9O9gAlrRgkUnX94vS2uGkTVZm3Pe25XSsMjD6F3acbGdPHO6tw3QEcaSz5TLpAnHl/DtJGStpwGZOm2I3yVEbJ6Y3tae9k72x8d6ODCTCgyGKTjIvwxOslAhLv58k7z9Y9HPORgDw/jwWw8/mvetgC64N9J0TDmb3Rjn5cOkSRxVUBrALr4M
x-ms-exchange-antispam-messagedata: t3T9qUQ+d0VmQKOr+iy5KsnJZg6ER1uDixaTe4jkX7z71eOOB8dw1+wZ45uC3sfueZHobzLcfTltkP8yimfEYdeaprDx8ZHBBGzC9xsnq8QlKJkkpEWYeimtMbzEWlLRw5SdKhD1ZqxhDf4tytzII1T8Hv9TrxdYNeesKLqdvZ2XQSUVCZ6XvA1AU97TWJexoaWQACnFIsB66b6kBvqACQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6fdc58-e251-4ed5-38c6-08d7da42a6e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2020 15:53:29.7888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YS9HTK2oN03MUe9jsQTx7+vJe82p55POw9Ekm1RDA86ImqP/1OJlYzWnVQtmIx1YDZvHq3cVWpmaTHTLRf6jZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
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

Ignore this one, needed to update the commit

 Kent

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Monday, April 6, 2020 11:51 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH] drm/amdgpu: Re-enable FRU check for most models v4
> 
> There is 1 VG20 DID that does not have the FRU on there, and trying to read
> that will cause a hang. For now, check for the gaming DID until a proper fix can
> be implemented. This re-enables serial number reporting for server cards
> 
> v2: Add ASIC check
> v3: Don't default to true for pre-VG20
> v4: Use DID instead of parsing the VBIOS
> 
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index bfe4259f9508..9d17761721de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -20,6 +20,8 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   *
>   */
> +#include <linux/pci.h>
> +
>  #include "amdgpu.h"
>  #include "amdgpu_i2c.h"
>  #include "smu_v11_0_i2c.h"
> @@ -31,8 +33,16 @@
> 
>  bool is_fru_eeprom_supported(struct amdgpu_device *adev)  {
> -	/* TODO: Resolve supported ASIC type */
> -
> +	/* TODO: Gaming SKUs don't have the FRU EEPROM.
> +	 * Use this hack to address hangs on modprobe on gaming SKUs
> +	 * until a proper solution can be implemented by only supporting
> +	 * it on Arcturus, and the explicit chip IDs for VG20 Server cards
> +	 */
> +	if ((adev->asic_type == CHIP_ARCTURUS) ||
> +	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device ==
> 0x66a0) ||
> +	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device ==
> 0x66a1) ||
> +	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device ==
> 0x66a4))
> +		return true;
>  	return false;
>  }
> 
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
