Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60F3C2BB1D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 12:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803632063A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 12:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0EvNQNF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803632063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32FF26E855;
	Tue,  7 Apr 2020 12:22:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5763F6E855
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 12:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyE3XEvTZgb3VU7pi94cU8ENS6OK5ehAyhCybcEhK62gcChgkHPsW78wqXur4Q6cMDVDCmDuPT+g6B433RqjkgRy6iES5xBe1mj+c6lIB73dHn5jGe7ciUZhJgvZmoF+PfFVsNSS8hmQcF5q3wmoyCcmeU+xe3oGZP+CzhjfkTBo2s1Qxfb9cPwp5sW2K524jcEbxf/CmZ3r8rAohVVDb/YdqfZrmtbHh4guNm/PjHaaLOPJmEa9gWszKUxxjfODu5vr6a6jQcZKjNYeiyGhJ56PJW9YpDDvbcOf+RkWcYF7z8Z4e2tVvDPVXnZ9WHub2MxGLdShIonqTue1oL7s5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZq48IKbF9+MfadR1152UBU7aPetfyFSOnb3Bv2idhk=;
 b=aqLJtN0V9OQ6j0fp+M9HNDrFb/PR4+V09voFS7oQNcxzjTTayk1SXTM/+tnzBY6VlEFK8UOYXJtfWLa3B4Phy9EnP/war35ySnh7FH3GSTIgqbvdT0btGJvvFXbNEOoWN0mvazlhhTxb4xKDO9aUdSU3MhUC7pYcc9dz2pFBP1hX0dgDXO40vGZryeNtN0QH+BlCe0uoqHsiuDwM/r83pMBMZXKCwEwB3XR8jQxh32T1HoCW/l07tYX5a/XuUOK/MAp2yMycK0yNS28Hc520KEOHCegrPR/lEqk52UbmHN3lCVTfcde5w2+IQujYo7oZiLoDzNDt1j0XtLLFr6Mm6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZq48IKbF9+MfadR1152UBU7aPetfyFSOnb3Bv2idhk=;
 b=0EvNQNF98Fq6FaaOxdCog9QCj8N+Wq6vgoTuA4EOMKh7XlxJQ6r71TST6R9wIESJKvn73zm7jWvjYWUaZmlBWTa8Rr2sxVvAEmuDwIicQ7nVjfW2+St0hlY08CR7vV9aIxok9+c2BdWWe4gWuw7bFQJ/ACLxT4FqtW67L7jC/7Y=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3801.namprd12.prod.outlook.com (2603:10b6:5:1cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Tue, 7 Apr
 2020 12:22:11 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 12:22:11 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Re-enable FRU check for most models v4
Thread-Topic: [PATCH] drm/amdgpu: Re-enable FRU check for most models v4
Thread-Index: AQHWDCtyGFDeqBN4Xk2JvDY4p/4mK6htlfAQ
Date: Tue, 7 Apr 2020 12:22:10 +0000
Message-ID: <DM6PR12MB3721A6490DEF76C87BCFEE5685C30@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200406155249.16576-1-kent.russell@amd.com>
In-Reply-To: <20200406155249.16576-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-07T12:22:10Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0cd15375-2cee-4919-be27-0000775a1a06;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-07T12:22:10Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 772d4e40-65db-4257-b44a-0000313d6756
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
x-originating-ip: [2607:fea8:1c80:c44:89d3:2a74:6d44:185a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c85fbd93-6a8b-47b1-e329-08d7daee4c27
x-ms-traffictypediagnostic: DM6PR12MB3801:
x-microsoft-antispam-prvs: <DM6PR12MB3801E4F0D59F9BA27790466085C30@DM6PR12MB3801.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(66946007)(5660300002)(9686003)(8936002)(86362001)(316002)(71200400001)(55016002)(81166006)(81156014)(8676002)(52536014)(66556008)(2906002)(7696005)(64756008)(76116006)(6916009)(33656002)(186003)(53546011)(6506007)(66476007)(478600001)(66446008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1KE7aXVn4Ts+UFQT9VTFiNHFg3TZniPmDwuJGAaJ32JSUbRYKte/Mq/8rNeOURNhunMZ4a8vmjL0oEvs92SKaonFthPj/oljRsh6MsvEZ4M/mjKBlc0R/l3xWduYubfVvsJ5IOmn3hxSJyW1ow85Xxkb8jvepiYgZRqjVT2LUP6arMboGkwOJDiWAiq5kQC4u7AM/jlbss78KpQELs1MVWt/PncpusimV19aEY6h30Sf0Bn8jl9BrlOcb0iivPHNoU31Qp2NWZDPKtpsKrWCG7E6a0uEw9X/zRQlj1GY1keLqJ4Ss17qXhGvum4lLSi9gHJ6G9+K7ZVWAthgiI7k1PxBHxm93S5RHCFGckmi21Ek3e5uZSbqKz7/aL6HTgpJqLJ8C0TQNUZ3NjXbfhtMzed7bv2WxD9iunlu4c2odLH8rcAE2y7fNgZnK+c+auS+
x-ms-exchange-antispam-messagedata: Nv/f8IUOVykTKGr761+as9owI0og9xuNLNG8CFTGhPYo0vf0cE3ZuV5+I5B40cr6llFBW7o1mzNZQ37vqNe+EVNyl+6wT2KI5/BX5xHpGfIoB+lCHQG0dm6kWTaxFWNyrfIw+I/PzbfCDaWJsZA4DVusJCXUDZ9AUWUUeagsLy037/2Uz6ipPG3ofZG4OXsvIKqjxDmaychiytUM2PnjJw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85fbd93-6a8b-47b1-e329-08d7daee4c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 12:22:11.0069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ScKVAKMCdYRhbDvDoTmnLl2XE+5XP/zlk1DnwBMa29fN85aV0VCYTXeIn6BIbgBd5rKGXWJorY0haqtyasysgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3801
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

Sorry for the double-send, this was the right one to send out.

 Kent

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Monday, April 6, 2020 11:53 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH] drm/amdgpu: Re-enable FRU check for most models v4
> 
> There is at least 1 VG20 DID that does not have an FRU, and trying to read that
> will cause a hang. For now, explicitly support reading the FRU for Arcturus and
> for the WKS VG20 DIDs, and skip for everything else.
> This re-enables serial number reporting for server cards
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
