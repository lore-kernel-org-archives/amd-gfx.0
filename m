Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BDCC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 04:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 699C9611C9
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 04:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699C9611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19B2A89CBC;
	Thu,  8 Apr 2021 04:16:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46B6489CBC
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 04:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk96/HpA/lFgzY0Ulnr5hU/LcRVKlGjt3TVMQ3MkdhTZPQC6D282QKsH3WC3AAqcFiUu/2xg52hoUWBbu0I2URJ4qev7vp9dRZEQNn8RVc71sIanCwUEHJ2P2OKOzvos0iKsFCLerUIbJKCJkO+TqhuJ1NAlaR1mmIr1O2ixRZNYrvzWsgzJDB9y0lSpQMSSwryQpvgAZJErJOaRG6HIMFkD47cgsRyawjZTBEVFuedhs5+w7oDZ2WL8u7MSGCUF9i4G/ILC4be7R9yEx8QqkzMUK1HnMkTf/UCYJWKsP3Is24Z9A3HabEJXqhkiry6K3x82kYWUxRbJ5dIuaWpvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDl5Dsa/iOXb4zf22aaz0xKtALzmGyAQONbAasMwEsY=;
 b=R86IvrykPSLcVCUDP7xN+C5lO6u85Q8uphEhzBCDsWWD5MhOiZ6b3wTtLx8Bh+dg7FyDfYR018514u0A6kbOy6QmKFLWujIjVMcSMDFWARIXBT+yoOFHNpDP59pStmgiXK34vUrQJdinlEK5qwVRxBZ8sRDJI6LokQmulnNDL0Yxx+R0Nm82UrSwDE2sqgsKx3cTiOrVTj3OkSTRZfl3NLWirNLIYGEVOj1dn8n/7S3/Z65elMh2ssegXd6BEBb0IE25pqbpQIJBaThD1pgfefGsmWC4w8JCaqoLZUmtpr/uSHpqqwuP9xkju7BMh90PKyKT9P+s/zRARUY+AxkP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDl5Dsa/iOXb4zf22aaz0xKtALzmGyAQONbAasMwEsY=;
 b=c8RW6JaoS/Mg3mpqKLAE8CG+tW4ppNKlQ+WBOrhRgI9NQPlyH9To+aYYEE22yzqktBwQIZlR0J8x+/2ele/jTiDwZv3zUh38sw1eaKsIj57NCfr2YbaSDmsmlrj+XAAg9n+L8cycplGue73O75r//ysojzcVIq94s7vIG703wRw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.18; Thu, 8 Apr 2021 04:16:30 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 04:16:30 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Sun, Charles" <Charles.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [0001-increase-time-out-2s-send-msg-to-smu.patch] drm/amd/pm:
 increase time out value when sending msg to SMU
Thread-Topic: [0001-increase-time-out-2s-send-msg-to-smu.patch] drm/amd/pm:
 increase time out value when sending msg to SMU
Thread-Index: AQHXLCk2mzdhgjHq0Eu8XxkAFEG4IqqqA4IQ
Date: Thu, 8 Apr 2021 04:16:30 +0000
Message-ID: <DM6PR12MB26194717EBE10ED54FBB91E5E4749@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210408034206.960849-1-charles.sun@amd.com>
In-Reply-To: <20210408034206.960849-1-charles.sun@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-08T04:16:28Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a99d87c5-8c1e-454a-814f-e32318c89aac;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afee2c67-1d01-4e1d-3568-08d8fa45163d
x-ms-traffictypediagnostic: DM6PR12MB2988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB298816117C546CB62F547A0DE4749@DM6PR12MB2988.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rjnBufQas7PuGnbuM+dJBqXWy/j+6chEq7bl7SoGeakuwkunbXV87ksgEw+DzreLhSn+SgvCcqKEUs2qh/92putK7Qko+a13c4/BVDWrNaC3ArOCDAgQaJ8u7L+Gh7H7YE8nsnMZeZrMSfZJNld07XyIduRP2PwVSsNtKrplNcddh1aaanaDu7GSzGMLri9/fCtT6y/MwxWAdi+t155So1gAvDQNOognZZli9+o/8hbJNVGFFL3ej8DIv//ir7VApotH6VfBRn2q6KBhTTMNCYXyeoLNwiZRN1RoOyU954MOX4VXOyiuEyYcdoSxSZfhpoHfigtFpV1o+Sfa17cUdv2Mf6FvJaEdx6diQU5UPcQEmQ6YTv+1CrVbssg5xyvQkJfWYaeEEaiOmwLBhyMRXv266TPGfsLCYH1ncu4IBNO37j5AdVCyZVnVmFIr3k8QtS+ZXY/nVoR5h2J700Lm/Pd9Krz/mZBfqcQ7zi0ZJuiqacslmXVseOG8d4H5o3aq9fPYPEb112sg2kHIl2SeUG27WX9U6QeSbIcQ1kbFUMo0tAg0+Sk1Zs1DShIlk0wC/6FjQCP4Gh1acCBTrWphrPYtoUb/uX3FNWx4tK/gOihvURR/h3xTYghaPAh0jIFI1/rJz7tZ3u/yzFT/5JSOdw3O2ufxz173O+P2qTVmrbTecE1k15MNDdIU821f8RC40mPaxeawJNBuVJSLk0sS98EqGjaOY07C+dOKMnrSQNg/XpGLCp6lHXMS9DkmZQNo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(71200400001)(186003)(83380400001)(7696005)(64756008)(478600001)(45080400002)(38100700001)(52536014)(54906003)(33656002)(316002)(2906002)(110136005)(5660300002)(4326008)(9686003)(66476007)(26005)(66946007)(66556008)(76116006)(966005)(66446008)(8676002)(8936002)(6506007)(53546011)(55016002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Pfg036AsanEn49RqzHVSf9WUTD0WK9ykQTW5uhdWgxq2XVDKXdnAeq2gRB/v?=
 =?us-ascii?Q?cGl49xVJguNt9dpFHkcD/8Ix42jquXZd8DuvznHmo9CXVs0OWItjLK1B+udR?=
 =?us-ascii?Q?B/2ICWECrgLyYHaaymE/hzmSgKxZ5YIG50Abfc9Xi1NySOZZuChyvycnLHL3?=
 =?us-ascii?Q?54oyzOKo7wyhj86g3YJB+28h6gayYkrhy9bFN+lA36TtDYypH+lpsM8Q6STF?=
 =?us-ascii?Q?4eXWkAH/0U9AT5FkTrM1PzGfhxRxPHpeUDHuMPFjZSk5qLuW+H9NY6L7qQbE?=
 =?us-ascii?Q?0wMjWdn4l4RcSAoHOpyl2Q1duQ+oRHbz0P3ocft5Qfme6g0vaaPK6E0fFu7/?=
 =?us-ascii?Q?G/JvuaXD9zo4F9zh3Ue5xZ7fKKy9HGRuncDBhEKkDw2IWGBfi8nHBYOg8P2M?=
 =?us-ascii?Q?H68P1vGUjJEvSEdDAQhhjLzof95wJBBu87AjAaM4Mb2uEBENODHLnoCCXXqM?=
 =?us-ascii?Q?WepywagRI4HZV1rK7Me1gPJc7WfvHSYfPBYLcRsrW5J81WEjSqW+nlsKt03/?=
 =?us-ascii?Q?tZEAxidSMLvwQrHFmI9SKaK0WQG3lyqg84NwQKNToAur0EgHYv4OrxPt/31K?=
 =?us-ascii?Q?HzX42c/1uip/1zmbSYlh3sLBgDd935UoY+OGfSysDuxuTpzvi2vGX7rRWyBs?=
 =?us-ascii?Q?2PJd5tcs086s/lw2t9sBgdjjtB3qmJLR+XVjZk/Hnx6nALlnb6Pfg+kbGUrL?=
 =?us-ascii?Q?6lWnl6tnc/KOoZGgAfGe9NxztSIXM6r0QRbZNx6zzqOvSrOrOVqlfcNkAH+j?=
 =?us-ascii?Q?qUTXU1s7YLRyqlEFOf/nRsnuHI2Kjrcj6wD8bYaqAwm8idaqb7riu9eFHvMm?=
 =?us-ascii?Q?Y/S41DRSbnPMPyZYtRV6PMOQUxT2qOUqa9ZzmOxrqS54Xsir+MfBdJoDAR9y?=
 =?us-ascii?Q?BH1DrdUX5hOHjxdsQ+0MB5oUbIMkB3JvToop29iILdt1JUgBkfSpCgxcbPb3?=
 =?us-ascii?Q?b6nP8eDm1MVLTyDlXFFRElIt59H+oa8xFo/YOXfbN8w8rey7e3ZbHNnK+7Nz?=
 =?us-ascii?Q?KCyTQkoUoMBz1Bd+pd/I5NoQ1wa0WhT14n0EQMgYy/IC5pPjTN6qls4k1shV?=
 =?us-ascii?Q?me60tdoqXBYou2uXfTxE9jCKYhcvksZVknlqUqytRE5rJl4mzC7UCWBpQ13F?=
 =?us-ascii?Q?s2ecVp8iZSwmf8PsIZIrMcU3+QlqRYmdrnajoGlQXupuA2CMJw0g0UE+6J+W?=
 =?us-ascii?Q?fKgKXabpfqoTFqaHpmpWo8F91Ed0VoYBv4Bd5X5pI6wsBOpFXQWQDGntZPc6?=
 =?us-ascii?Q?GVouOuivbsc8WGvZGPz3o05Yr+aTmVQg3PlmIOI2p3Tn2EXD0c/RxJZgC6fE?=
 =?us-ascii?Q?+XTw7ustxbH3IKtAwWmf5hvp?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afee2c67-1d01-4e1d-3568-08d8fa45163d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 04:16:30.3144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /lTGaajqHb94MqTWEq8bhzb3mxXPpCZ/i1m3CaecQZFse/Ta9wSw5XZYm4lpzsbL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Su,
 Jinzhou \(Joe\)" <Jinzhou.Su@amd.com>, "Liu, Zhan" <Zhan.Liu@amd.com>, "Sun,
 Charles" <Charles.Sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> charles sun
> Sent: Thursday, April 8, 2021 11:42 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Su, Jinzhou (Joe)
> <Jinzhou.Su@amd.com>; Liu, Zhan <Zhan.Liu@amd.com>; Sun, Charles
> <Charles.Sun@amd.com>
> Subject: [0001-increase-time-out-2s-send-msg-to-smu.patch] drm/amd/pm:
> increase time out value when sending msg to SMU
> 
> when do S3 stress, low rate that PowerUpVcn message will get response
> more than 1s, so here increase the timeout to 2s
> 
> Signed-off-by: Sun, Charles Charles.Sun@amd.com
> Acked-by: Deucher, Alexander Alexander.Deucher@amd.com
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index b725f263092b..dc7d2e71aa6f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -79,7 +79,7 @@ static void smu_cmn_read_arg(struct smu_context
> *smu,  int smu_cmn_wait_for_response(struct smu_context *smu)  {
>  	struct amdgpu_device *adev = smu->adev;
> -	uint32_t cur_value, i, timeout = adev->usec_timeout * 10;
> +	uint32_t cur_value, i, timeout = adev->usec_timeout * 20;
> 
>  	for (i = 0; i < timeout; i++) {
>  		cur_value = RREG32_SOC15(MP1, 0,
> mmMP1_SMN_C2PMSG_90);
> --
> 2.25.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C9924c6be21724c736
> b7208d8fa40576b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> 7534501546436504%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
> nyya88jiGFYBVvr4fuZfiO9SZpspw2KxP0o9xaiaTig%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
