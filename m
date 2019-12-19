Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3712C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 07:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8F224650
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 07:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KMOsx+//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8F224650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F415E6E0E8;
	Thu, 19 Dec 2019 07:16:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A93226E0D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 07:16:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehnDBkvePeMuaFYOjcLkEDESElR3jRTZdj0A1sL93qlMquNxWEsyNVFH/ojgeuIjuZQZknI4Nb1CcP1kU5f1TggheVg45oQygbwHEDuVXiVHojW7xUNcrlASd0R3YzjpZiuPf6E0/DSAOSUNLRV4xxM/BSYIe2GSmfb14ctl1Z7+nM+GSxttuAwJHXofWDzmJ/wG3RkJkfCIidm9/2SXD2Zf5dk4ZTmuFjSzUFqJXAD0XX/sIysAmugT5tBANVGfHKTfgrfWFDDqjwBM43Iwl9gLuu5GJIM/c/qGi+1bWF2aZRPwp+c3RmRWcX6YKigwW21XXnUXl+MMhKphFzxlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbQ1xkuWIFg1QgXVDw5UfSQPD3U4m68PzqjPqnphUF0=;
 b=IZ9f9ZU5VAez/W1K5Ovmt+nhEgzAW/RWuAum6hzgCwwGnM6kaW/W9LGU25frdOw2+37fMbW6wcUewaU9qaXYGpuBFkHvuk1ghZU5R+kU9fh+9ohunRfU6nonFiM4X1clFz9jmNQnzi4HjxfirmZ1iWIMZxqU3Nee7lEr0jiPJ5erz8H2sa+smBq/yQ6I6tfn+AbO8/vX5g+xyoyElm1SRnXXz1CygepkF9dh84DIn0e/TWMZadz4u7cC4smIuhDjm2oZKab2Y0T5rF1r0HPD1lDDFI7pQYN2U5r3m+B/66ucPF73a5FXgaIQbizST+3e1sOkWS65ewreWwx7h4WT9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbQ1xkuWIFg1QgXVDw5UfSQPD3U4m68PzqjPqnphUF0=;
 b=KMOsx+//OZJaXGta3JrkdRnGan3pgodWeRPg54sUhtSFZO5atoD8aT9H26J+sqhbNaA5AQCshRyA+XWlS6fLgp1/CRcC86/WmlkuxNaG0tmB5HOK+m0ZplyE8khfx7S96qoyeW0vHaiYjUj88demMSWJuFppicugYDrDrwWWBOY=
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3951.namprd12.prod.outlook.com (10.255.238.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 19 Dec 2019 07:16:46 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7%6]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 07:16:46 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Dai, Yuxian (David)" <Yuxian.Dai@amd.com>
Subject: Re: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode
 overrun message
Thread-Topic: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode
 overrun message
Thread-Index: AQHVtjfuypezFmPpxE+PJkDrkNUqBKfBCJgAgACJcYA=
Date: Thu, 19 Dec 2019 07:16:46 +0000
Message-ID: <MN2PR12MB33090EA9087D882E30D957CCEC520@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1576737930-20998-1-git-send-email-Prike.Liang@amd.com>
 <MN2PR12MB37434D66DE4F972A1C29C8268D520@MN2PR12MB3743.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB37434D66DE4F972A1C29C8268D520@MN2PR12MB3743.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-19T07:16:38Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bd59e76f-2715-4983-97c8-0000df5d4662;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
x-ms-exchange-imapappendstamp: MN2PR12MB3309.namprd12.prod.outlook.com
 (15.20.2538.017)
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-19T07:16:38Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ad6558b8-c110-4704-988c-0000882320cb
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32d2c48d-0bb5-40be-bc78-08d784536879
x-ms-traffictypediagnostic: MN2PR12MB3951:|MN2PR12MB3951:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3951D08F18655CABC5B890EBEC520@MN2PR12MB3951.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:267;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(199004)(13464003)(189003)(33656002)(26005)(53546011)(316002)(4326008)(6506007)(86362001)(8936002)(5660300002)(55016002)(66946007)(15650500001)(81156014)(7696005)(186003)(81166006)(6636002)(76116006)(9686003)(8676002)(71200400001)(54906003)(6862004)(66556008)(64756008)(66476007)(52536014)(2906002)(66446008)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3951;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BPMPH5a6YiUS9Ig8vbKzeDW1nR7NIHNVv/mHG2aHPlmJP5RWg5MXgqKKKSAaAEA7a4FXqCuB5brjzEoNPqKLjWzhaGKjY6/Lum7bxMPE29caNuuCYex75hm/+DC/Qx3+mkfKUDIbRSmSi4u5V0InTinF1WOE82cladEHjDWo0KewzcZ7deQVtIMmp9lC30Uj8YHFCgWA626kzNZFkybwTFE3kpx75hwl3NxoQVHfGmDdZJi2uy83xmbrn+9IZ0Wy2b7LaorGuWF+XY+/7WuLUQsmpH3gDdl8L4fDufhGHZzM+My2SJymyHHH2JjnTHnyqaUj4Df5/nozepMYmdpgOcnzR/jxC8fgjZGj9spthkFa+1TiVdaLhP5BA4hReQQ9Jetcl5QZKhgFZrq1PPbcG+3Q4SjDoU3ydpOtJX1r91GkPguYLoM98vhM2PkxyeXRCb8ebWNOOPyok+9LZBcKGoBv3wlG2O5lHQdhgzHGwW34aluLwTQuiig2Yg7DXXYW
Content-ID: <BDDA32918705E44999E0E93529B39D97@amdcloud.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d2c48d-0bb5-40be-bc78-08d784536879
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 07:16:46.3936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82Ylh3jd5T+7e00yCFjFMyHgbbuzPcMRX+jz7tG7NDGU8dxeWaBxqai7Q45YCAE6xzIf69kJdYuLjC+BFG8KAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
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
Cc: "Liang, Prike" <Prike.Liang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

On Thu, Dec 19, 2019 at 03:04:12PM +0800, Dai, Yuxian (David) wrote:
> For we don't support the mode, so shouldn't print the error message, or regard as a error.
> For log message, the error is high level .maybe change from "error"  to "warning" , it will be much better.
>  
> 
> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com> 
> Sent: Thursday, December 19, 2019 2:46 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Dai, Yuxian (David) <Yuxian.Dai@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amd/powerplay: suppress nonsupport profile mode overrun message
> 
> SMU12 not support WORKLOAD_DEFAULT_BIT and WORKLOAD_PPLIB_POWER_SAVING_BIT.
> 

Probably smu firmware doesn't expose the feature mask to driver. Can you
confirmware with smu firmware guy whehter this feature is really disabled
or not in SMU12. If that, in my view, issue the message
SMU_MSG_SetWorkloadMask with an unsupported state, it doesn't make sense.

Just work around this with one time warnning is not a good solution.

Thanks,
Ray

> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index 784903a3..f9a1817 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -550,14 +550,18 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>  	workload_type = smu_workload_get_type(smu, smu->power_profile_mode);
>  	if (workload_type < 0) {
> -		pr_err("Unsupported power profile mode %d on RENOIR\n",smu->power_profile_mode);
> +		/*
> +		 * TODO: If some case need switch to powersave/default power mode
> +		 * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
> +		 */
> +		pr_err_once("Unsupported power profile mode %d on RENOIR\n",smu->power_profile_mode);
>  		return -EINVAL;
>  	}
>  
>  	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>  				    1 << workload_type);
>  	if (ret) {
> -		pr_err("Fail to set workload type %d\n", workload_type);
> +		pr_err_once("Fail to set workload type %d\n", workload_type);
>  		return ret;
>  	}
>  
> -- 
> 2.7.4
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
