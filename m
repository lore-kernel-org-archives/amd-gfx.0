Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E235C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 06:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA67365012
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 06:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA67365012
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D5A46EAD6;
	Fri,  5 Mar 2021 06:14:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192676EAD6
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 06:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOkHPNOw4CKsyvpkDph0eFBk92GQmJhtJmDzzGAtwaYBpxKIOYsE04rSjukuhTbUm3eET2nhX2JsVuhtbPlfFXsRIYHKukblLXupItoVjr20og9YSzpppRIYUhpQSlIBpL+oWSMhnTWV5Gsi2ibXcL2GwarQTVo/UzjctZEa//kMwqsATwTBwlhlZx7108L7ZV/7wy5quiVN00n1qyRL/9l4hs8ECfoypEJycOtj2ZtZ/GnJvGqKOlS1W2VAFFHpdh1r/NNsQdzAmEx8MbY2Y9j+Y/ctPABKWrhLCPvvwfNp6MNUf8e4OnU7D/3qKK3HAf1/bhAdeorY/NVhLbUL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCeNxQIMqNnzVdOqsIAFJqip+cxQN+OdwtSIgOKUKTc=;
 b=IpRkIVM4V88+nJG6huopc8XcBRk1MeKssDsCzUKHiZ2s/dF4EwScTxDKzfq/R/kUZEwkzQ61AIwJYrLmCWehZmXKy8THD/e9g33XXhB3yTyCS+xAtIEY2ljXjUVcU0L0BUR3fB4sb3e7lEvVbhVooYIIy3YQyW+BKNpHqEHLRSdhikK2RkNGzZ91kvdQrqDH8DE5EIsPT/tDEkMfuQ1F/ldhPw4Bgsy+TuXEYAE/8snojagGH2w+trp5Fq+5QKm1PjFbB5yR/VC8RgzxAgjt7SoxcN1RX3fGVRqtG0NsX6rmHUsffrsLYFvvb7ZMuo40pTMd5U28z/hoNFxXBDKUiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCeNxQIMqNnzVdOqsIAFJqip+cxQN+OdwtSIgOKUKTc=;
 b=V5+LE5OFEnyFAwJ2P8o7NFB5xJUvvbRxbqO36kpOyOiVFe87oY/5nOoVsziFY/u6L5GHJtWrM57mN04wbUrrBbPRb6YZXPMzku3kjwNt34csmr6d9CQvPrdRPnR2YYAVi5xMdoEjNRGFKcB4C0Fhx8tW4fduv93ClXwiTUvPLqk=
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 by DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 06:14:34 +0000
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::28e0:5877:b4e6:6bdc]) by DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::28e0:5877:b4e6:6bdc%9]) with mapi id 15.20.3912.023; Fri, 5 Mar 2021
 06:14:34 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: add fini virt data exchange to ip_suspend
Thread-Topic: [PATCH] drm/amd/amdgpu: add fini virt data exchange to ip_suspend
Thread-Index: AQHXEYZ+x5suuAIPTkioHejClbFoi6p06g/Q
Date: Fri, 5 Mar 2021 06:14:33 +0000
Message-ID: <DM5PR1201MB02040CCB95E3462B4A7FBB1CBB969@DM5PR1201MB0204.namprd12.prod.outlook.com>
References: <20210305061157.312421-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20210305061157.312421-1-Jingwen.Chen2@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b1b253bb-230a-4bed-bd89-12f2a6027b7f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-05T06:12:44Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3230633-df63-440b-5857-08d8df9df245
x-ms-traffictypediagnostic: DM5PR12MB2485:
x-microsoft-antispam-prvs: <DM5PR12MB2485A107D5F257138BAB7FFABB969@DM5PR12MB2485.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ne/Kjth9QVtlMMTZ2lpzOStDaHGunX+5ba5Jcn87UQ3DEdyJW8b5Xmo7XYkBdjOAb0AdBBXbal44o2g3PTpTma1axjoG+cBIU87pDW02Nvqfo98KOK/3yYWAZ0xhmjKT5Wv7VcZ4LuAGWJUWDkMtC4wD+Uux5ytEsp6J7DXQxShVKkzrvjOMBfVf+n6Dcik+DP9lfCNsakbeUsIj2WTSQpQfvuVZA7OuQeTdDnOcxL9I4dFZg6X9P9rhjAU/9BO7ZcPFiXop6bXiHO8WdirjO+4S3yMUyuRZKBh7dd/RKuW3kFdo0Z5PyV1+0yS+IXIfq7hRleYaP10vXPORToIuKRES8FufSosqanrFjzLhAhOp2iUYrhXwMg9yPPRO+NSU5OS/aPp+IR33vO/3e2zy74ls8aZlBu8IuCe6SW3dKcVjhDtldnwAWafHGTIhnEeG/+A+k62X4vj3tBlGHY5sCrp6CYSLdSeAGZb7X9CSPTCsZ1sKwlKUFIynGn2ZHRk2si04tGr1CrDEi5RGjGWYMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0204.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(55016002)(186003)(6506007)(7696005)(478600001)(9686003)(6916009)(26005)(83380400001)(71200400001)(53546011)(5660300002)(66446008)(66946007)(8936002)(76116006)(66556008)(2906002)(33656002)(86362001)(52536014)(66476007)(8676002)(64756008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?bXdKdDlOUTJpZFpCSXVqSG4ralZUejhPbFlrUkRydm01V2RMdDNZMm5iYmhZ?=
 =?utf-8?B?aTZBejM4dlJCblVseXI1SmFGUWpxWmVYRXpaL3pnSVJmaGRaKzJiUnBWeGpS?=
 =?utf-8?B?eitDQ0d5NzV3N04xbzRoQ2Z6Z3B6NnI0dW9lZHNKMDllYW5ycExjamZMZzJp?=
 =?utf-8?B?ZjJicmZTQUVZWE00dlJxOFB2TzNmZmJGRjd2SERjYXUwdG5VN3F1azdsd0tw?=
 =?utf-8?B?V2lIVzAyNkN2L1FZdEMyNXRSY0RSdkp3SG5RTENYbVZlaFNkc3JjTjdkNnRj?=
 =?utf-8?B?aXZrWk1lK1BBNmM2N0RxY1I4L0M1a0pDU2dYTTNqVjFtMnhiWVJSckx3elpD?=
 =?utf-8?B?M3Z4SVFHcjBsMGxMalBPekw5ZU5MYStVVzdSMTcyN3dNcDdSUUJsYVdYNzg3?=
 =?utf-8?B?T1JFNzQ2K3pMTC9naTdOa1RSaGUwMUloSmVXVDZMVTFDRm44QnRWRWNCN1hI?=
 =?utf-8?B?TmpkUHRESHhFWVJSYkVLMnA3NzNiMnZFQ3BUSzJuUjM2N0pTVzdpRGFXc2Ju?=
 =?utf-8?B?dFAzQXFKU0VvQSt3eUdLR3p6YUUyYnAyVkFJbHpVM0lVNlpTMU84dDZXeWdE?=
 =?utf-8?B?a3RqZGFqUUY3VDRNSUxVdjJTUWM0TjJNTFRXTW0rNWNXd1gvajU2TlYyU25U?=
 =?utf-8?B?RWlMSnc0R2VYVEJZZm5NTUwrT1QvcUlKR3FKaitCNHozVy80eHFEL2Ixbm55?=
 =?utf-8?B?VytwWTdTVTJNcTE2TWIrZVhFN0JhbUUyeFA4c2lSMGd0dVhYTUN4S2VTMXBC?=
 =?utf-8?B?cG1QUXVuRGFGMmVlellVMXU2U2NOQ3BweTVyMStSQk5RWHBFQ2FOT1ljWnZM?=
 =?utf-8?B?a2RnWC9pOUdvdzhTU3JyNTdybmRVdHpGSTVWNDRUdGlmc2lDSlFuNlBUTWc0?=
 =?utf-8?B?cERCNnYvaTNEemFRMUhLRXJ4Q1BHM2ZJNElHbmZYQmxQS3czVFMvNTQ3ZzM5?=
 =?utf-8?B?aC9lMmlkQTA1Q3V1SEVodFZVZVpuaktUSHJSMnJZbGdEejlMN2J2R1QrbzU4?=
 =?utf-8?B?UndzcGZxbnFKSVc0ZUhzQ2hpbmwwVnE2NG5rcUhWVWdjRjh1STlacGprZGVY?=
 =?utf-8?B?VithQjFHd3pHU3dncTZsWHJreGdETmN4SUpZbklnQm1uY3JYbXBIM2R0cHBh?=
 =?utf-8?B?U2g1cmxoNGthMGlVSXQzQzV1NTdjOEdsQkIwNXFPTGI2ejMzcXd6MVdNeVNN?=
 =?utf-8?B?TTRiMUhlN2ZVb0tTTm5qMkxYcDFyOWZIenNUWTNGa2lhNTNwNlBUOGxteUFi?=
 =?utf-8?B?bEt3RUw4aFFqYlYvNWFIb05JTlorK2xRS0JQakZOcHBET1BHS21FRjdNemlS?=
 =?utf-8?B?S0RUQWdCdGVpMzZoVngyUG5KTlZ6SVYrdHcrS2FwSUxaTGpmSVRienVnakRv?=
 =?utf-8?B?ZmxYRlljQzJpRTdpb0RnSUpXQmZaZlVOTi9mR0crWlY4SUNSdkV0cTE0dlBp?=
 =?utf-8?B?MGU4UnI3dTY0VnRhanhXTnRzOW8xWEw3K2luS2dvZ1hxMjJGN1QrOG1nMEVw?=
 =?utf-8?B?dEY4eFVGWWRJQThqdnJDeFpDWXRwZTFmUkFEZ3dONVYxYUdWcEp6NUVaOWZt?=
 =?utf-8?B?WVU2VzlOL0hrUXIzYzRnVlBpQzFsSjdnaU0vRFhKRnFNR29FSE94WFZuWHo4?=
 =?utf-8?B?M3FTOUJKMEZ5UVZIcWVnNHI1SEJjY1YvclVmSG9Bb1VOS0h6bDY0Q2I1WUQx?=
 =?utf-8?B?MjZYTDN6cS93RFRPd2liWTkzTG8va1B1V1JsVStRMmFyZ2thZkMzNHJNcG9z?=
 =?utf-8?Q?/+e4w38K47V+X/xxeu+iqn1WhevPugEU3IL8YHN?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0204.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3230633-df63-440b-5857-08d8df9df245
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 06:14:33.9515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ribVnV3sXdOvZN8oW/M1bKopzul/txhZdAk8wwsrwV7ezXJ+47B0Z4cKP8eHvBLk
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

Reviewed-by: Jack Zhang <Jack.Zhang1@amd.com>


-----Original Message-----
From: Jingwen Chen <Jingwen.Chen2@amd.com>
Sent: Friday, March 5, 2021 2:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Horace <Horace.Chen@amd.com>; Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH] drm/amd/amdgpu: add fini virt data exchange to ip_suspend

[Why]
when try to shutdown guest vm in sriov mode, virt data exchange is not fini. After vram lost, trying to write vram could hang cpu.

[How]
add fini virt data exchange in ip_suspend

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a11760ec3924..bec725b50c1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2774,8 +2774,10 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *adev)  {
 int r;

-if (amdgpu_sriov_vf(adev))
+if (amdgpu_sriov_vf(adev)) {
+amdgpu_virt_fini_data_exchange(adev);
 amdgpu_virt_request_full_gpu(adev, false);
+}

 r = amdgpu_device_ip_suspend_phase1(adev);
 if (r)
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
