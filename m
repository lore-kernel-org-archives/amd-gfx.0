Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9206C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 09:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4586710E0A6;
	Wed,  3 Jan 2024 09:36:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A02910E0A6
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 09:36:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgP9O/T7XHMuKRl6YQNBpMh6qUmZB+Kev7RRvY9sd7zfLq/PGbrOV7lWGzwzVj1/yNfW6+djxudAmYPFuA3x5OZGnE3rZmak9ZmCj8I0pJoN36NS27Q4xFnYxBRFT/2/i6OIJAoFIAJ3CBR935vYMEa+62tX6N3a85hVyaf0ltr1hbzjTyHemrK8/1Wu84yK6LChhnXkEWk80Er00sKaYp4GTkLTdeXqjn7lEYZX1DVN5+YA1B3XvE5/6SJI7dxE0dXv38ZUToLmyEWBGkrtOM2U0bDej19D/OgV4J6glAMe2Nfa7IULzPw545ZfskakMzjGCpHFeYuM6fqKGLH2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35w0Gtp2WvxUjzZBZ8ug4H/NjvPYV1sjlZ1W18eyWxw=;
 b=K491kGs1Eo0tkX1nNeDHcdFi8yqlXT92TzueMRGPdGhcXF0yNK+6pL+dTV1z3f9m5g71tKtYPbsqBGGq1bU3jMbD3p48557PEJIPGwfqlXTXjJnaCHrocwMBMdzUr/yXXthK5bWUh/F1eDOlpf3GXt4mgkNeXVSx0bC5HVO3NAecGlX03cjK3qViGNLOs0iAv/4fh3NdguC7JheMxtgyH+MeMElu3bpSKGYuVCTqMS1/jf+E/tvPOcbH+Ovks/uH/RvMhMGcxg6inVWE0Z/Oys/rz7qCaT8t1JWolCk3rdI5nfm3dMZTCx8DR64iJz2E8bt/c2EE9ELb+lTLhE2h4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35w0Gtp2WvxUjzZBZ8ug4H/NjvPYV1sjlZ1W18eyWxw=;
 b=mVcYEb2HXnTvl6CFDoYqORABoo2Ov60svG0oF6Sw7+2al4pqlP5RfJ4XGraMcWWD1IJVO9my2mgS698LqlCVOnzfWzE3gfiBZYt07GZth2WKlvyktgqXgd7Op7dnzcLW8YGaVJzGu6rDeQIcrL1F5cJm64cX90dbrcMThbEZyPo=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 09:35:57 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::eec3:bf1c:4deb:8810]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::eec3:bf1c:4deb:8810%3]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 09:35:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error log
 support
Thread-Topic: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error log
 support
Thread-Index: AQHaPhtLkMVBVmkuJkqbGjtj9RVCgrDHw+Pg
Date: Wed, 3 Jan 2024 09:35:57 +0000
Message-ID: <BL1PR12MB5254BCA35F540F3169D8CFECFC60A@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
 <20240103080220.2815115-3-kevinyang.wang@amd.com>
In-Reply-To: <20240103080220.2815115-3-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=61f822be-dba5-47ee-bf0a-7524a42547c6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T08:37:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5254:EE_|SA3PR12MB7973:EE_
x-ms-office365-filtering-correlation-id: 097ddb4f-b725-438e-26ed-08dc0c3f63b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vZvro9vtfSixANXKukn1RirptM53sBKllwQhUTny8KCVFgcsats8lStYSAznHHRryuuGhnoWzMUYXvoBUgcgKpDQ3RjCoxQp08YQgDXbttJsH7oSuE64RTeoimVUuE5NIcRQ3VhBjzJ2BzHTkqN42uU/ZI3nMHAUimKfiwR0MzDYknWWmGQZHs+wlxZRFBCeGziLSe0jebwLcXsBByjvb8iOpBskcYGXLZae+2wnPFwQXDk5EvPXRT7EZLQnp0X8aKHcSDNcggCvWhvTcVC0lmFHL4uny3jphtUBtEQhvOUH6T/ugVFnAU9DuTZW6PQ4tKcdAzutGn3b8lpzQTr2wT09xhQLc5fkyJop5cJJuObiXoCbDhoabCa1LLtieeSrUWQ/P6YPrCVUmGDUdnqb8dPB/jfDSQkQ+ah0C6spaeysMi8K7BDUEMIv2GX2s4Dl556AS64BObdDPcEUWtgqMh0XzlB7G+KtcgfXTME8Ri5qzc5MRxvt4Ij1YN1/YMueh2m8KaUNTbrux1EGGF89E/9PbVXCPvpGUSWaZvJM8J2lY4uid0jbe7b55igtg5Ncoze2CWvIYN9YRe3liw589XlUdyaTaFciHdv4xwpE+1J6N+TdVrEsrvdsHoN0WVZx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(71200400001)(122000001)(66556008)(38100700002)(83380400001)(76116006)(110136005)(66946007)(66476007)(64756008)(316002)(66446008)(54906003)(478600001)(966005)(86362001)(33656002)(55016003)(5660300002)(2906002)(30864003)(52536014)(8936002)(4326008)(8676002)(38070700009)(7696005)(9686003)(6506007)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RVVUT25ieG1ncklIQTBBUlhSeVB3QXpxbXdRazVpKy95ZlFpTW9WVUha?=
 =?iso-2022-jp?B?VEtpV1Y3Nm9rcUozZGVHNGhtRVFRRnNPT09FYXlFNkduM2NBK2dGL0k5?=
 =?iso-2022-jp?B?SjlhWldiVEhsYXdxWE1wUHpJU2hFSVA2SkdUSEVpbWNaU3FpUTlFRXhi?=
 =?iso-2022-jp?B?YU9xamlWSzBVTHFhZ2M2N3k5MDBtbWtkUVkyNVA5L3B3aXpSdGtqNDV3?=
 =?iso-2022-jp?B?ZjVZTFNYSXJTK2lrZGpLVm8vU1Z6ZnI1dy9zbkpueCtmWGVYRmxDTkEx?=
 =?iso-2022-jp?B?N2ZteEJEVkowY0FxRnc0WVpKMXNuNnFDbHFCQ3k2SnpVRmdGV2dRRFFr?=
 =?iso-2022-jp?B?aFhhaWtIc3dVNTF3NzRGbHhKbjlrZXVVWFRPMElXMVpIUXlweFNXZmJp?=
 =?iso-2022-jp?B?aXFmRDJWcDhrQ2RUR0RGUjFuV0VFY0JpT3c1MDFBaGpkcS9Ha3d2QVBi?=
 =?iso-2022-jp?B?VjJxVHZvbGdibHpQOUxkdVM5NUZDbTNMUDhaUVlrN1BvVFNwVlNWcjI2?=
 =?iso-2022-jp?B?S09FSFlxZkFUaTFwb0pNSGo1dmgxTnBDcldMQnhjWTRoNG9mK1ppUzMy?=
 =?iso-2022-jp?B?VmJsTDQrajdSWjUwa0hCbUZIUjh4Ymx5TTVJMGlxUjhUTUNyUFNsUkJF?=
 =?iso-2022-jp?B?MHZVTWJmTTJ4cm1ZYnE0YlJQMWU5VDEzd2w5OEZCek5EdDhOK1BYY05z?=
 =?iso-2022-jp?B?cVJuRnhHbjZ3dlhvNDQzck55L1ZSRWdlVzd3c1l1NERWc1Z6UzR3bDhK?=
 =?iso-2022-jp?B?UEcxaDVyOHBqem1ITFFVd2NFdEtZMW5CUWUvZ0ppOGpkQUhuV0MyRzgw?=
 =?iso-2022-jp?B?cUZCMW1MeXNRNnAydFNKYkwzWE92TEhiWWdFWG9ZdlQxNkYyaHNQeFVR?=
 =?iso-2022-jp?B?UlVONHBqYWRTMlpxYjdtOVJhczFxNzB3WDd4emJ6cjd3U3phS3A3VmNz?=
 =?iso-2022-jp?B?aUpSRzhKK1VDWXBqNWIrWDZySUtoWm5DcEFINEVObGhURXUyU0h1TXVj?=
 =?iso-2022-jp?B?clkrQ0k2dmx0UUtaVkhGUW1UYzVFM2lvay8wUkY5SXFRUTJPVXh5bUtC?=
 =?iso-2022-jp?B?SXFKSXZ1SDBaZlhuRTRsaVBNR2M4VnkrYlR1dnlmK3hUSzhTaU5HM3BL?=
 =?iso-2022-jp?B?SlVWZ3ByaEVBZGQzNGtTV0gwY2ZhTzZGYXZBQzlGVTYvOHRWWEZHQTE3?=
 =?iso-2022-jp?B?T0FLVUFibHlTTFJwNzE3UTZxYXR2VkpJWWtJajZHaTEvSXNLckFFZDlI?=
 =?iso-2022-jp?B?RFhRZjdORklOMEpjMlN1TFoyVGdhbURaSndSdTF5MUNFbE5pSExLZndN?=
 =?iso-2022-jp?B?YzRjMFRpOVZCQS9GTzRDS1Bid3g0dVlyWTZTQXZYT1l0emM0K1pibm8x?=
 =?iso-2022-jp?B?M1hRdHMwWnorWEs5T202MEVmRHRUVW9DQjEya1RXZjhGb2FxM2RIeVRo?=
 =?iso-2022-jp?B?SGpTZjcwWGJVTlJaMFJ2TEx3RExaUGRYcEEvRWtQeGt5bXBTSHpWblFy?=
 =?iso-2022-jp?B?ZGExaFN3NGhrNDFoYTRSdmF6S3JkNWZCYm5SWVlLdnNIVWhUMEcrN0lj?=
 =?iso-2022-jp?B?ZFlSWTd1N0xRbUhPMjVqVEloNWFpVHNxYTRYZ0x5R2xKbUt3dFp3YVJV?=
 =?iso-2022-jp?B?OHBqNG9pd0ZOUGhHOC9CWkVHc2hIb29yWk1QNE1GcW9HT0VMa3hXUXFV?=
 =?iso-2022-jp?B?S0tJbTNkM1VvWUNWeGpEeTRNUy9Kem8reFVvaUlnWU50N2pvOHlqb3BB?=
 =?iso-2022-jp?B?RGF6ellyM0N4b0w4Z09UVHMyVnNESlcvVGpBQlY4aXBFRmQrTUc5Q2h3?=
 =?iso-2022-jp?B?MjRraGV6Kzk1V2hOZVpkaTBGbDhaQkZqNnUwVFRKVzR0SlNMRm9CNFc0?=
 =?iso-2022-jp?B?b0VETVU1Smg5Z0QxTytGYmNCT0lxMGt5Skh4L09BeGlxREtnS3VmT0pG?=
 =?iso-2022-jp?B?cXlJOW4xaWxsQS9qQ2ZYTlR2NUkya0dhUytoRjdkWlZMWkc1d2lTQ3Rt?=
 =?iso-2022-jp?B?MVJ1aTljcnZRTkZKT0syWkNsUXZhbHVKOFdvRGVvQm1nQmszdnpwa0Ev?=
 =?iso-2022-jp?B?Zzd3NUd3c3ErOFVLK05QNG52eFFxcjM4ckJobDV0cmgxc3ZNVUVhN1Ez?=
 =?iso-2022-jp?B?cExuRDZMeS9UbVYzdENtZFlSYUd2ekgwWjdUVmx5dGpYWWUvZVBTQmho?=
 =?iso-2022-jp?B?QVdETUtBWEh0Ym1QMnZtVXNvTXdWUW1sWnUyazkzU0Fwc3JhVE9SMVl4?=
 =?iso-2022-jp?B?OFd4empKZG80cE4ydjNidFg0YWdsc29oalVwVDZ0Z1NzWVQrdStWVSto?=
 =?iso-2022-jp?B?cHpiOQ==?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5254BCA35F540F3169D8CFECFC60ABL1PR12MB5254namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097ddb4f-b725-438e-26ed-08dc0c3f63b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 09:35:57.4295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sSdE17pUuZqHRD+W+5l3cLkDhCUGTsjt6zRCPX7bOooOBWraTYFt8BH4iTCSaRiUcmy6LNMo7Qf7RSKEDJXHAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5254BCA35F540F3169D8CFECFC60ABL1PR12MB5254namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


+       dev_info(adev->dev, "[Hardware error] Accelerator Check Architectur=
e events logged\n");
+       /* plus 1 for output format, e.g: ACA[08/08]: xxxx */
+       for (i =3D 0; i < ARRAY_SIZE(aca_regs); i++)
+               dev_info(adev->dev, "[Hardware error] ACA[%02d/%02d].%s=3D0=
x%016llx\n",
+                        idx + 1, total, aca_regs[i].name, bank->regs[aca_r=
egs[i].reg_idx]);

We should keep the ACA log format simple since there are tools like crash d=
umper that grab these logs.

How about formatting log as below
dev_info(adev->dev, "[Hardware error] Accelerator Check Architecture (ACA) =
events logged\n");
dev_info(adev=1B$B"*=1B(Bdev, "[Hardware error] ACA.%s=3D0x%016llx\n");

In general, if the idx doesn't convey useful information, then just replace=
 it with ACA.Reg.

Thoughts?

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.c=
om>>
Sent: Wednesday, January 3, 2024 16:02
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Z=
hou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Chai, Thomas <YiPe=
ng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>; Wang, Yang(Kevin) <KevinYang.=
Wang@amd.com<mailto:KevinYang.Wang@amd.com>>
Subject: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error log suppor=
t

add ACA kernel hardware error log support.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com<mailto:kevinyang.wang@amd.=
com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index 6a6f167b5380..cadeda64eded 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -100,6 +100,33 @@ static int aca_smu_get_valid_aca_count(struct amdgpu_d=
evice *adev, enum aca_erro
        return smu_funcs->get_valid_aca_count(adev, type, count);  }

+static struct aca_regs_dump {
+       const char *name;
+       int reg_idx;
+} aca_regs[] =3D {
+       {"CONTROL",             ACA_REG_IDX_CTL},
+       {"STATUS",              ACA_REG_IDX_STATUS},
+       {"ADDR",                ACA_REG_IDX_ADDR},
+       {"MISC",                ACA_REG_IDX_MISC0},
+       {"CONFIG",              ACA_REG_IDX_CONFG},
+       {"IPID",                ACA_REG_IDX_IPID},
+       {"SYND",                ACA_REG_IDX_SYND},
+       {"DESTAT",              ACA_REG_IDX_DESTAT},
+       {"DEADDR",              ACA_REG_IDX_DEADDR},
+       {"CONTROL_MASK",        ACA_REG_IDX_CTL_MASK},
+};
+
+static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int
+total, struct aca_bank *bank) {
+       int i;
+
+       dev_info(adev->dev, "[Hardware error] Accelerator Check Architectur=
e events logged\n");
+       /* plus 1 for output format, e.g: ACA[08/08]: xxxx */
+       for (i =3D 0; i < ARRAY_SIZE(aca_regs); i++)
+               dev_info(adev->dev, "[Hardware error] ACA[%02d/%02d].%s=3D0=
x%016llx\n",
+                        idx + 1, total, aca_regs[i].name, bank->regs[aca_r=
egs[i].reg_idx]);
+}
+
 static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum ac=
a_error_type type,
                                       int start, int count,
                                       struct aca_banks *banks)
@@ -137,6 +164,8 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_de=
vice *adev, enum aca_erro
                if (ret)
                        return ret;

+               aca_smu_bank_dump(adev, i, count, &bank);
+
                ret =3D aca_banks_add_bank(banks, &bank);
                if (ret)
                        return ret;
--
2.34.1


--_000_BL1PR12MB5254BCA35F540F3169D8CFECFC60ABL1PR12MB5254namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - General]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;[Hardware er=
ror] Accelerator Check Architecture events logged\n&quot;);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* plus 1 for output format, e.g: ACA[08/=
08]: xxxx */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(aca_regs)=
; i++)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; dev_info(adev-&gt;dev, &quot;[Hardware error] ACA[%02d/%02d].%s=3D0x=
%016llx\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idx + 1, total=
, aca_regs[i].name, bank-&gt;regs[aca_regs[i].reg_idx]);</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">We should keep the ACA log format simple since there are tool=
s like crash dumper that grab these logs.</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">How about formatting log as below</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">dev_info(adev-&gt;dev, &quot;[Hardware error] Accelerator Che=
ck Architecture (ACA) events logged\n&quot;);</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">dev_info(adev=1B$B"*=1B(Bdev, &quot;[Hardware error] ACA.%s=
=3D0x%016llx\n&quot;);</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">In general, if the idx doesn't convey useful information, the=
n just replace it with ACA.Reg.</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">Thoughts?</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">Regards,</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">Hawking</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">From=
: Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com"><font col=
or=3D"#0563C1"><u>KevinYang.Wang@amd.com</u></font></a>&gt; </span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sent=
: Wednesday, January 3, 2024 16:02</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">To: =
<a href=3D"mailto:amd-gfx@lists.freedesktop.org"><font color=3D"#0563C1"><u=
>amd-gfx@lists.freedesktop.org</u></font></a></span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Cc: =
Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com"><font color=3D"=
#0563C1"><u>Hawking.Zhang@amd.com</u></font></a>&gt;; Zhou1, Tao &lt;<a hre=
f=3D"mailto:Tao.Zhou1@amd.com"><font color=3D"#0563C1"><u>Tao.Zhou1@amd.com=
</u></font></a>&gt;;
Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"><font color=3D"#056=
3C1"><u>YiPeng.Chai@amd.com</u></font></a>&gt;; Wang, Yang(Kevin) &lt;<a hr=
ef=3D"mailto:KevinYang.Wang@amd.com"><font color=3D"#0563C1"><u>KevinYang.W=
ang@amd.com</u></font></a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Subj=
ect: [PATCH 02/14] drm/amdgpu: add ACA kernel hardware error log support</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">add =
ACA kernel hardware error log support.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Yang Wang &lt;<a href=3D"mailto:kevinyang.wang@amd.com"><font co=
lor=3D"#0563C1"><u>kevinyang.wang@amd.com</u></font></a>&gt;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 29 +++++++++++++++++++++++++</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 1 f=
ile changed, 29 insertions(+)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 6a6f167b5380..cadeda64eded 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
100,6 +100,33 @@ static int aca_smu_get_valid_aca_count(struct amdgpu_devic=
e *adev, enum aca_erro</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_funcs-&gt;get_valid=
_aca_count(adev, type, count);&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic struct aca_regs_dump {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *name;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int reg_idx;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+} a=
ca_regs[] =3D {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;CONTROL&quot;,&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_CTL},</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;STATUS&quot;,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_STATU=
S},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;ADDR&quot;,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG=
_IDX_ADDR},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;MISC&quot;,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG=
_IDX_MISC0},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;CONFIG&quot;,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_CONFG=
},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;IPID&quot;,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG=
_IDX_IPID},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;SYND&quot;,&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG=
_IDX_SYND},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;DESTAT&quot;,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_DESTA=
T},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;DEADDR&quot;,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_DEADD=
R},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&quot;CONTROL_MASK&quot;,&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ACA_REG_IDX_CTL_MASK},</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int </span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+tot=
al, struct aca_bank *bank) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;[Hardware er=
ror] Accelerator Check Architecture events logged\n&quot;);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* plus 1 for output format, e.g: ACA[08/=
08]: xxxx */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(aca_regs)=
; i++)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; dev_info(adev-&gt;dev, &quot;[Hardware error] ACA[%02d/%02d].%s=3D0x=
%016llx\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idx + 1, total=
, aca_regs[i].name, bank-&gt;regs[aca_regs[i].reg_idx]); </span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_er=
ror_type type,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; int start, int count,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; struct aca_banks *banks)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
137,6 +164,8 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device=
 *adev, enum aca_erro</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return re=
t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; aca_smu_bank_dump(adev, i, count, &amp;bank);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ret =3D aca_banks_add_bank(banks, &amp;bank);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return re=
t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BL1PR12MB5254BCA35F540F3169D8CFECFC60ABL1PR12MB5254namp_--
