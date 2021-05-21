Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59447C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 06:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13556611ED
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 06:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13556611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11986F5BD;
	Fri, 21 May 2021 06:57:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB15A6F5BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 06:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjZLy4hBxKZpnvVW3hxXU8A4HnLCAFxitQ9jyMRPQ1RndKOrobXe10EboT/vPsHR350wQAyqxJTBAudJtn7S4l2oaksXXp/bFB1SxNgBOxSUDtCIv1k0AmH7yGVPE1lLBfX9Ee/uAI1CY+6g+UxulgeihtHCjgoDjPE9maeGg9yAf+quz6qZVBbYWcEqpHhimUSn1NYuShhMnBLW85HAe9IZWpCza9Wr1apOxwAQBXc3RBoVJqd7Qn0UVwZwKUMHhOBQUQM48+LKD3mBPzgIPb26f3V5xKDkLCcKFHZWsjP/oZHOqiBEDF7R1v/caGlafYd01UxSEk7zMU3uLvfRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWLcvcaMHc9pU4srhuVgCyR+KBgyYe4asDrqwmH0k3E=;
 b=COSPFarrDop9OZIEpt/OvhST383z7LSmUVa3pYCPBija9/LlIPkYYCAlEeuNgVROe62kn18MqYtrUSjynGmS04heobXhNkr/R1b8CfTevGNXbQyOcHgVNGZlc4InwzHLpwA/V65/g5RMSXwAZ3VeTSBQEy8ek2P347RYpuMUCm+T2F78Qob9fwqOMDXx1N4+CC73RUA9ZpUQLJfi6y6z01LFV6XdzI1z4k0UhHt0vgQKMUZaVYKQ714bUfWB0fCjjvf+xvFKfCyPJfa3wEb6qMFKydYo8mHykNfqQs70wbsPbvzWF2iqaH1Ek9OBhtghVyoMH6Upi9pKj0pwmiwmvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWLcvcaMHc9pU4srhuVgCyR+KBgyYe4asDrqwmH0k3E=;
 b=w8lxL/xiM67EBCzwvO5e79a2BLdxhyVT76n9ifWckTjgRRnq7YLY9reQKzQR8B469sfIAmxq9StqyT/Xv/BcSEdLIJQvvdXgCrnCOdnBQ/wVIPqCYYHyLjGiJeIkY2WCleGqrReeyKj/2XUOikWCWlANMzTyvXU+XCWJpDZj45o=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM5PR12MB1162.namprd12.prod.outlook.com (2603:10b6:3:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 06:57:27 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::555d:5042:518f:50d6]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::555d:5042:518f:50d6%5]) with mapi id 15.20.4150.026; Fri, 21 May 2021
 06:57:27 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix return value in aldebaran_set_mp1_state()
Thread-Topic: [PATCH] drm/amd/pm: fix return value in aldebaran_set_mp1_state()
Thread-Index: AQHXTV2ZQDaJqnqTPUqQ007oGATrGarsOT+AgAFGYrA=
Date: Fri, 21 May 2021 06:57:27 +0000
Message-ID: <DM6PR12MB46037FF2774451B32A219F8AFE299@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210520095038.3684183-1-Feifei.Xu@amd.com>
 <376ccac0-1bad-717b-312a-14a7cfd1bb89@amd.com>
In-Reply-To: <376ccac0-1bad-717b-312a-14a7cfd1bb89@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d01cdcd4-f6c9-42ea-8213-b7b877f425a6;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-21T06:47:35Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f0621a4-eea2-4f18-4716-08d91c25b21d
x-ms-traffictypediagnostic: DM5PR12MB1162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11627AA739E23422026F40C1FE299@DM5PR12MB1162.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wvyQrgaFN11cVzeE0Wsz+mb0RrbKW7O1advjRUCljOV1XbkrflmAq8sLLItMifEW3uYUL3X+9ieiQ+Y9dh9WIHH7qdf286+zzCJScKSb4zZCBL3o+sXJt/alZhV4wsOFMK2CiupsQnVSgqll1ed87VCrzvWsO3H2ItzJmti2/OYxI1+aktixs4VgudEb1Oi543vHJXLvVIXe6wvm7FiQ8tImHEynx4TbU5ORAAPK5w0+uIbqwaA0Whcno3qbby+vodAorVciKYgdtu3UOQA4ZZL7J3+6R71RgVqmkG3Ha4asFH+wm9ZoaEPtiw0VV++0JeOnVg9cRPoN9lEguOpJB5OR6Aaraz+ztD2HM1CfngAqpJreozxOBi/La8PZ0y8n+j2s2XGWL/MWcO5rn495ejeiFJD0KfuWJ93tBpp/VhiK/cBDnmMrnz4msPmoeycB5vRdfADD51eWtQ8wl4LTmzI49N1c5b5UX2O+Byj4dce8KeiaikdTo2EjekRiizCapGRswWPKlq/Sl2X+YVO9FQMV9vArEtOW70HXpPkjsVirAQPOYl/yqTl6hTxwmZSJI5nYM4ZZTCKJeo+0RfzjjQ0uv8osnh+j3X6J24BhMws=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(66476007)(66946007)(76116006)(110136005)(33656002)(186003)(8936002)(7696005)(66556008)(66446008)(83380400001)(478600001)(38100700002)(122000001)(9686003)(316002)(26005)(64756008)(2906002)(6506007)(86362001)(52536014)(55016002)(71200400001)(53546011)(5660300002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?d2hvRXZDMVlQL210cXU1YkViMGgxK1B0WUZneTZQN2hVOFBPRGs3QnYxRkZm?=
 =?utf-8?B?TE13dnVweFZJNktKMEV0V3ExcDBEY2N5N0V1aGlvZ0d2bFIyY1hGMzJKVHBS?=
 =?utf-8?B?cy8ydklyaG5Bc3ZNdnNvU2Zid1Z6aHZNTEpqbk9nOFh3TFNZRU1UQ091VjR2?=
 =?utf-8?B?bGI1ejltcUtyNUoyT3pqZFZDR05tTFQ4YVB4MXZFcmdsTlE0REZFMUxta3NT?=
 =?utf-8?B?ODY1REdubWIzdDdScGg0MkcrMFptU2pCS3dweFN5Rld3TU9hRG9JTWVHU3V5?=
 =?utf-8?B?REhwalZ3YkpJZTkxei9VR3FUVFdDdmxvU3c1SlZJNFB3UW11dlJtcVB4QldY?=
 =?utf-8?B?eGVxaDhOVWdjWmlQNDNvdmFYdXBRSCsvTmcvcFZzYlE2Q2QyMGJYdEE2blo5?=
 =?utf-8?B?UU9sQ2lIL2VFbnZVSE43OHNYZFMzRWtNeHBpR2RhRUZEUjMxVHEwZ0J2ZkZn?=
 =?utf-8?B?MmxabklvWUpDT1ZVQWkzNWpFNGZzWWFLakNobVk2Ly9sUktPa1Vnbk50L2Zj?=
 =?utf-8?B?cU9CUTdhK3NCTXN5ZXpSb1JMRnJ1c1hzbnVJeVkzbFFCSWswelF4MlhWMEh1?=
 =?utf-8?B?aGxLSEtLc2ZpSk0zZlFFUS9qMit6U1I3VW1JU1FndndvNlBycjVYMlRCNVMz?=
 =?utf-8?B?cE0zQVQ0TWdMQXc5b0FwaC9sVFZPU3d1TTJkOWdZYkNHMEFBTURmZFJLcGVB?=
 =?utf-8?B?eU1ZcGNGT25yR25FalpuMnByVVl6SWl2aURDYys1U1BvZzFrL1VXNzdJYVBz?=
 =?utf-8?B?bDNlRXlFdlFtMWI0Z2wyR3pSZXR0RFRnQlhSV1lxaWVSQzliS0NSNzZ6M20r?=
 =?utf-8?B?aGVyUkE5azlQZmI1ZHlkeDZZK1lqa2FwS3J2TlI1TTVFMy9JeE8rMUhqcWxp?=
 =?utf-8?B?VDVuNXpmNnFqVUw1WTlsWitTa3hTUHN2VUd2RG9yWWx2U21EMzJ5VTJ2OHY0?=
 =?utf-8?B?bnVGWlpwdS82UVE4V3NQNTIwMGQ5dG03TUJHK3p1SDNzY0IwZ0gzWjhuRmM1?=
 =?utf-8?B?V2xPalo3bWhhemtmYjVNMUUzT1ZxeXpCa1owMHRWYnRFTXVmR0Y5TnllclA2?=
 =?utf-8?B?ZXlFOGtMcGJydUE5MGdNWEQ3WitCK1JnVGhFQ29ldTQ3WWs3d2s3Ly84c2tw?=
 =?utf-8?B?b1g5ZkVCekFZZ3NxSjYrb0tLZEE4Nkl3TEVESUNWNUkvVVRiVHV0aGl2SERW?=
 =?utf-8?B?b2hqNHIvWFdtTmtBNDdtUzdNRjVhbXpYSC85NHRqd3Rxaks5NVFpMDBWVjZG?=
 =?utf-8?B?b2xieWVjSnpMVE9WSUJ3S2dsV2thcDNGU09Oc01SbmlJQ202a2ttZnRpZ3dU?=
 =?utf-8?B?VmdMc01RbWVFYUg3R0EvRXgzZENEUTBWSWVTZHlPVmtERXFMSWh5V3MzMjBI?=
 =?utf-8?B?NTRWTFFmNkFyK0dXWTZqcDVRbnp1Y0dPcmtOV1hNbXFmWS9iMitncnN4V1Fu?=
 =?utf-8?B?c2xsWmp3ai9oM0Vhd1FuTE5RcmtzV3ovNGJkb3dKUzRjUXhLdlJxelVCOEpX?=
 =?utf-8?B?MEpCSERnK1BQV3J5cHFCTWs5cVNQdlhaRHA0bHdmMEtqdlZveUxPbnV4UzB0?=
 =?utf-8?B?bG5lalNSYlh6cXUvQml2cWgxQVpJQXdwMG1SbDBFNTVmL1k0VFY0cEZ3akhz?=
 =?utf-8?B?S3A5QlpITWxWRkhvbVlVSGFuVXdsRmRJVENYVVlMM2puYXJRbVJUT1l6RzRD?=
 =?utf-8?B?Z3NWVVFudkQ5UXNIZGRyNXRWeDNnRHZQUG8xSkdWNTYzOTBUcUZtZ3pDUjlH?=
 =?utf-8?Q?889uXiry2knp1KcaC9QsLEduXOeFyVe7P5RT4O4?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0621a4-eea2-4f18-4716-08d91c25b21d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 06:57:27.6437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+SoO/lZ8NoExcGvXYj8abTHCA9DVduwiwQE4racWG6oPlCQVPG9HDM4LUOcYM2i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1162
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

[AMD Official Use Only]

PP_MP1_STATE_NONE should be valid while other 2 are not for Aldebaran for now. It depends on whether driver want to throw out error if the msg fall out of the 4 cases.
Benefit of handling all the cases will be catching potential bugs easily. But the handling of these 4 and others are the same in both driver and PMFW - which should skip and return 0.
So I am ok with the simplify code logic. Will take your suggestion which return 0 for default. Thanks.

Thanks,
Feifei

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, May 20, 2021 7:19 PM
To: Xu, Feifei <Feifei.Xu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/pm: fix return value in aldebaran_set_mp1_state()

This now handles all of the states. Those states are not valid (and therefore not handled) for Aldebaran. If the intent is to skip handling of any other state, may be just return 0 for default or skip default altogether so that it falls through to return 0 for any other state.

In any case,

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

On 5/20/2021 3:20 PM, Feifei Xu wrote:
> We should just return error in invalid case. For valid but not
> implemented one, do nothing and return 0. Otherwise resume will abort
> because of the wrong return value.
>
> Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 5d04a1dfdfd8..5fcfd8e1a548 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1781,13 +1781,15 @@ static int aldebaran_set_mp1_state(struct smu_context *smu,
>                                  enum pp_mp1_state mp1_state)
>   {
>       switch (mp1_state) {
> +     case PP_MP1_STATE_NONE:
> +     case PP_MP1_STATE_RESET:
> +     case PP_MP1_STATE_SHUTDOWN:
> +             return 0;
>       case PP_MP1_STATE_UNLOAD:
>               return smu_cmn_set_mp1_state(smu, mp1_state);
>       default:
>               return -EINVAL;
>       }
> -
> -     return 0;
>   }
>
>   static const struct pptable_funcs aldebaran_ppt_funcs = {
>

--
Thanks,
Lijo
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
