Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460F2CDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 04:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC6210E262;
	Tue, 17 Oct 2023 04:50:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B1C910E262
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 04:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHMi8+YVlCSv8ykfiInmkd3sTctJIgiTu78TVWlzyRBP2G1R7RRUcE9YdOYFdUvUNEK466LbU5by5Bob49G6a/mor3OJ2uL6NT30ByGvLVs8rFs56d7f8mpHY2md0umYyskNEm9oMY5Yjs641BMv3dhwJRs+Gu+gI0dYlnIcAsQzDZnBDTytMIwx7jSGSKonXg6PfBW+gFfE5totyXNr/39ShD/5YnQa9rP+0KX9zk28xcMOYM0jgZUiKaFQRAEiwfaWOdbkRYtFoTt2ppeeian5oZ2dz1sfQ49cgvtTwiPt7ZTVq4ctHiRpDPC6jc8Yl7h0FXP3EiPQYZVJmH01Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3JDi7MGwD9bDFkufHkOD75Bv+AihapU1ZQUaKXYUoc=;
 b=i9BEeiBACSuGBkZU1V1NcSGKUe6bZ6xqMDXAdFLhSdrCODV59oatqFZihac3LYXqbAY5bhPrTDV0oyxenOL+esrdpTbn157IO9BMjgyhSarO9411A2ZgU35xNqCMvXLlNFct2qDjiLXRP/ekSdoNiz9vtFDErY79k9aWHVsXIaBRMZr1USCBx0hovwNn3Fo6xMag3f9mliheRIg2P/Bu3dVLdA/Mmi+LSDNnPYkA/ONV6+59hfORTjEqZjRS4w6dF8ZJPV5ogMUmTktHDiBWlQON5O6pjJKnt9U35ArcjKC7yd/bL+9fe6mwIxabRsxZtQHQj23YdtQDLkV2fdkdgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3JDi7MGwD9bDFkufHkOD75Bv+AihapU1ZQUaKXYUoc=;
 b=zfhNgAsBp3+OLChfQSJ0kCyfhtsImXY4BFcqwV09Vxa/IeTjZzRh+N01MAN3X718kWJi1h7IEMGMw4FLgel3Nrv6jcGft8a0yrpGUKJIdBGET+USl3RLQJ5KJKCKba27imElmpxAFxyGhAJgigr2ERB8MTmp1Kzg4XFjufoD+yA=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by BN9PR12MB5177.namprd12.prod.outlook.com (2603:10b6:408:11a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 04:50:40 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::d59b:2efd:b690:583f]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::d59b:2efd:b690:583f%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 04:50:39 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Candice" <Candice.Li@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some conditions
Thread-Topic: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some conditions
Thread-Index: AQHZ/OqnbIlCFddPfkqVm44LME7tLbBGIiCAgAFNCQCABflVEA==
Date: Tue, 17 Oct 2023 04:50:39 +0000
Message-ID: <PH7PR12MB7988F397C68AFC16AD059D959AD6A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20231012090034.31055-1-tao.zhou1@amd.com>
 <20231012090034.31055-4-tao.zhou1@amd.com>
 <BN9PR12MB525713DC934E04C624AF57BEFCD3A@BN9PR12MB5257.namprd12.prod.outlook.com>
 <PH7PR12MB87968C30CFD03482D4CE8952B0D2A@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB87968C30CFD03482D4CE8952B0D2A@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-13T09:05:44.387Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|BN9PR12MB5177:EE_
x-ms-office365-filtering-correlation-id: 753b0b3c-fc7a-4b5a-615f-08dbcecc9c74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KVjoEZbpFaHAVRekTnfHkTxpt9XlfyPDa46h9kZgKvV+ClCaR6qECUoZtGxvy4z8IfKTEx6gXA8jspKaoInchLzSYn9E+za6iQo3e2yCc+lZgM5cbuNIfWptMi3Ung8KhyvCr5R9VPwA9KTAPcFR7+e2fVcDaeFpmZmUDUyullQ8pQnL0gmDIKn7BWs20qvwFPC2lhsVLsW9mH/uN70p0Pj1siqY46z0gkAa2H9hFucgCTj/v+L/7RjCIOmVY2tLb7yOJ9eBeporzSVMrQs2iafIs2PZxYV4QnLL7I3KlNbhX6Ja+r83tYf/BnFPvsAprtnyqQnjqnJ7+gv6kMqVoVWVW+kHv8+XwEigvFAW3apJ3AcQpxkUF1ACrXiJJNzIh9aBlz5SBmJvq9It/U1PAE1bWkKDRjwLefbFV78PY+URG6T2kZ96O1DmjtlSJkj/YUUm0mTfllwvX8cUSi5fjfKAokyM0qU3ws+W6bKpGxQ4iaV6cEH3uKypsYoY4aS0b8h0QMwA/hKY1jcCdGsfs6g133omz/NLDDTteu5cIZEoUJZtJ/zhDXNQfyU32Fhh5fuvJqnn7ldAROt0elJLuwdcCKJQ6iOFAifzTm+yyAjMzleTcPgCV2AECXfC8SVoMQIqDkG75LAjpNCkA1pEOA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(316002)(71200400001)(66476007)(478600001)(66556008)(110136005)(66446008)(76116006)(66946007)(64756008)(6636002)(53546011)(6506007)(26005)(9686003)(7696005)(8676002)(8936002)(52536014)(2906002)(41300700001)(5660300002)(33656002)(38070700005)(122000001)(86362001)(921005)(83380400001)(38100700002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1XHC7ZBSqH6yGsqRJel7/CosYy76uWws6dS3s32JxPxHGN5AMg6mbQYtOfPd?=
 =?us-ascii?Q?nVbgi2Ank6IMw5ar9+zBynv4vR8d4xW2KLmNB6KOdgR2ADaE8+3JQG/7hgmB?=
 =?us-ascii?Q?cJQvwO3jVnfeF9cBx5kBH2gWKOQz5NILxlT2PoxItHfYgZhRsvRTAZGYUPCo?=
 =?us-ascii?Q?bDtvLeT3e/gH8SliBKS8D0GMZHRKrLVaQp+KmH7nkU1xKIE5XbLMLQogcri8?=
 =?us-ascii?Q?9j09VjUX0GtXO4Y718A3SYq7h7yeZO3rPx+ors5GRvPe3XUY6iOn10usUBUt?=
 =?us-ascii?Q?FTw9kmmUtBC+il11PJu00oUlh8GCAAbw+Xvcov872cxB0djIB3osAtPm+lFq?=
 =?us-ascii?Q?WeeiZQEvRWjm1q026SBXxE3Hmn15On83/OI4gwtgMhzy+qAUHMS6GGGZkFY5?=
 =?us-ascii?Q?d3BJhxzXggzufsmT7XRthqLVxlzG4VSlRv9Z4rlvdfWLaNkuK0QiQKic2mxX?=
 =?us-ascii?Q?gQakNN1SZts2DjfHGzvg6qyQ2dkJbWMeQ+oKpkEARfb/LEOyqTiw6AP46G2N?=
 =?us-ascii?Q?5SmE5pyTV0OdFJBsM2G8GEvexsH7HjJMQkS7Ka+P2Z4mM7vI2hANBdKdE04F?=
 =?us-ascii?Q?5f30n1V9yXZMfgW29cA+3BdBfVjlFbGfW2xNcAvx/OMupIOGis2cBf6dKkN9?=
 =?us-ascii?Q?GcO6t+mDqQErxSyE3USJg5Rq9dBvuWfeuMdfIg7KPkEHA8XPp7bL1hsBmOfB?=
 =?us-ascii?Q?nyQDCXc+kr9xYFcmuf4GzZbxfD0cvKsYxDUJE/XsUIf5Y5EB4ayNbBGqACzg?=
 =?us-ascii?Q?5ot7TWIHhjKxhQlgsxGTvc1OJO7srCS4YTyDCSXbWVF+8hpQboV0liwyTWul?=
 =?us-ascii?Q?Xj0lwawKSCoXHgGhmXa2r6waKALDeZT+R81a28BSYHLGo3Yr0l0zX5uZIXO7?=
 =?us-ascii?Q?LVpZ1wPxwLoi+w+ZPtCNBpquzJVQYYvqToHXH3kdZdzmximFDjX7ZZQQ124A?=
 =?us-ascii?Q?xDt/nmX2amZ5mHv9L0pP8prdHFZrLHErPtU+ydMyPtlZDohXDXbYW8B2lKFc?=
 =?us-ascii?Q?SrWPqV5d3a1KwFF6yuVsvQ6k7IxVKaaWF5+yK9xiwCyhWRTHxX66FJuk+XcL?=
 =?us-ascii?Q?kfArWLGULkwjrE7TWtR66vbdTRhwlZFPGT+8kL6es9Sd23cDQ3UCaxksnu3M?=
 =?us-ascii?Q?WDAauJst70jpifNBQBGYCTRpJButv12RX4edM/EpUWxz/OMKPv06ZdmOGpPy?=
 =?us-ascii?Q?Ht7CZhGN05t4htCWyRzbSZ4q7ur4Zp/mdCTI6GXxf7GIyvcBexlD5rvGquKN?=
 =?us-ascii?Q?2CtlRzJEnVEhootCIdOjmW07EEeXAMOaGSyOnpoVPQ4r3OEfvxx1rCSVbgyc?=
 =?us-ascii?Q?0UCRsfufWTee/qPrvgclhgF7eBnaSjiZhaWsuFZdy4kWFyMZNXUq4HQPQqKz?=
 =?us-ascii?Q?amBD1gcDe9a23ACdpLlk5Vc3rCAtu+XWj+oc84Qmr270mM2eSl8UzNW7pCyw?=
 =?us-ascii?Q?BAQirc+Ikg+BsOUCdr9gy85XLaCCsC46XefCMf8/ckrPC/0Ec9yQ8FuSrXbQ?=
 =?us-ascii?Q?JL82IU0rqCyPuxhWWENxWFoiKNdIAPV0lHnxBgiSfvKlRQAx+ENiwYwHgGBs?=
 =?us-ascii?Q?SquxPazd4HEwgNHCn3k=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB7988F397C68AFC16AD059D959AD6APH7PR12MB7988namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753b0b3c-fc7a-4b5a-615f-08dbcecc9c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 04:50:39.6418 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46l5anynn4P6XHyRCNEDn0SprFvL8+xwWWhf4pg/UxiWHVtpZLspcH1f/JE0rEF2eZiZI2/0XiU/eLETwkq+bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB7988F397C68AFC16AD059D959AD6APH7PR12MB7988namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

The in_gpu_reset is set after reset error count and reset error status func=
tion call, so we can't use  amdgpu_in_reset(), please check ras->in_recover=
y flag.

Regards,
Stanley
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Friday, October 13, 2023 5:06 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; =
Yang, Stanley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>; Cha=
i, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some conditi=
ons


[AMD Official Use Only - General]

How about this condition:

if ((amdgpu_in_reset(adev) || amdgpu_ras_intr_triggered()) &&
           mca_funcs && mca_funcs->mca_set_debug_mode)

I use amdgpu_in_reset to skip touching it in all gpu resets, not only for t=
he resets triggered by ras fatal error.

Regards,
Tao

________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Sent: Thursday, October 12, 2023 9:14 PM
To: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freed=
esktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Yang, Stanley <Stanley.Y=
ang@amd.com<mailto:Stanley.Yang@amd.com>>; Li, Candice <Candice.Li@amd.com<=
mailto:Candice.Li@amd.com>>; Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPen=
g.Chai@amd.com>>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com<mailto:KevinYan=
g.Wang@amd.com>>
Subject: RE: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some conditi=
ons

[AMD Official Use Only - General]

-       if (!amdgpu_ras_is_supported(adev, block))
+       /* skip ras error reset in gpu reset */
+       if (amdgpu_in_reset(adev) &&
+           mca_funcs && mca_funcs->mca_set_debug_mode)
+               return 0;

We should check RAS in_recovery flag in such case. Reset domain is locked i=
n relative late phase, at least *after* error counter harvest. Please doubl=
e check.

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>
Sent: Thursday, October 12, 2023 17:01
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Ya=
ng, Stanley <Stanley.Yang@amd.com<mailto:Stanley.Yang@amd.com>>; Zhang, Haw=
king <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Li, Candice <Ca=
ndice.Li@amd.com<mailto:Candice.Li@amd.com>>; Chai, Thomas <YiPeng.Chai@amd=
.com<mailto:YiPeng.Chai@amd.com>>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m<mailto:KevinYang.Wang@amd.com>>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>
Subject: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some conditions

PMFW is responsible for RAS error reset in some conditions, driver can skip=
 the operation.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 91ed4fd96ee1..6dddb0423411 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1105,11 +1105,18 @@ int amdgpu_ras_reset_error_count(struct amdgpu_devi=
ce *adev,
                enum amdgpu_ras_block block)
 {
        struct amdgpu_ras_block_object *block_obj =3D amdgpu_ras_get_ras_bl=
ock(adev, block, 0);
+       const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_func=
s;

        if (!block_obj || !block_obj->hw_ops)
                return 0;

-       if (!amdgpu_ras_is_supported(adev, block))
+       /* skip ras error reset in gpu reset */
+       if (amdgpu_in_reset(adev) &&
+           mca_funcs && mca_funcs->mca_set_debug_mode)
+               return 0;
+
+       if (!amdgpu_ras_is_supported(adev, block) ||
+           !amdgpu_ras_get_mca_debug_mode(adev))
                return 0;

        if (block_obj->hw_ops->reset_ras_error_count)
@@ -1122,6 +1129,7 @@ int amdgpu_ras_reset_error_status(struct amdgpu_devic=
e *adev,
                enum amdgpu_ras_block block)
 {
        struct amdgpu_ras_block_object *block_obj =3D amdgpu_ras_get_ras_bl=
ock(adev, block, 0);
+       const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_func=
s;

        if (!block_obj || !block_obj->hw_ops) {
                dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",=
 @@ -1129,7 +1137,13 @@ int amdgpu_ras_reset_error_status(struct amdgpu_dev=
ice *adev,
                return 0;
        }

-       if (!amdgpu_ras_is_supported(adev, block))
+       /* skip ras error reset in gpu reset */
+       if (amdgpu_in_reset(adev) &&
+           mca_funcs && mca_funcs->mca_set_debug_mode)
+               return 0;
+
+       if (!amdgpu_ras_is_supported(adev, block) ||
+           !amdgpu_ras_get_mca_debug_mode(adev))
                return 0;

        if (block_obj->hw_ops->reset_ras_error_count)
--
2.35.1

--_000_PH7PR12MB7988F397C68AFC16AD059D959AD6APH7PR12MB7988namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.contentpasted0
	{mso-style-name:contentpasted0;}
span.elementtoproof
	{mso-style-name:elementtoproof;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">The in_gpu_reset is set after reset error count and =
reset error status function call, so we can&#8217;t use &nbsp;amdgpu_in_res=
et(), please check ras-&gt;in_recovery flag.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Stanley<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt; <b=
r>
<b>Sent:</b> Friday, October 13, 2023 5:06 PM<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Li, Candice &lt;Ca=
ndice.Li@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Wang, Yang(=
Kevin) &lt;KevinYang.Wang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some =
conditions<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black">How about this condition:<o:p></o:p></spa=
n></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"contentpasted0"><span style=3D"font-f=
amily:&quot;Times New Roman&quot;,serif;color:black">if ((amdgpu_in_reset(a=
dev) || amdgpu_ras_intr_triggered()) &amp;&amp;</span></span><span style=3D=
"font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black"><o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"contentpasted0"><span style=3D"font-f=
amily:&quot;Times New Roman&quot;,serif;color:black">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mca_funcs &amp;&amp; mca_funcs-&gt;m=
ca_set_debug_mode)</span></span><span style=3D"font-size:12.0pt;font-family=
:&quot;Aptos&quot;,sans-serif;color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black">I use
</span><span class=3D"contentpasted0"><span style=3D"font-family:&quot;Time=
s New Roman&quot;,serif;color:black">amdgpu_in_reset</span></span><span sty=
le=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black=
"> to skip touching it in all gpu resets, not only for the
 resets triggered by ras fatal error.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black">Regards,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black">Tao<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@=
amd.com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, October 12, 2023 9:14 PM<br>
<b>To:</b> Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1@am=
d.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanley.Yang@a=
md.com">Stanley.Yang@amd.com</a>&gt;; Li, Candice
 &lt;<a href=3D"mailto:Candice.Li@amd.com">Candice.Li@amd.com</a>&gt;; Chai=
, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Chai@amd.com</a>=
&gt;; Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">Kevin=
Yang.Wang@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some =
conditions</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span class=3D"elementtoproof"><span style=3D"font-family:&quot;Times N=
ew Roman&quot;,serif">[AMD Official Use Only - General]</span></span><span =
style=3D"font-family:&quot;Times New Roman&quot;,serif"><br>
<br>
<span class=3D"elementtoproof">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!a=
mdgpu_ras_is_supported(adev, block))</span><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ski=
p ras error reset in gpu reset */</span><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (am=
dgpu_in_reset(adev) &amp;&amp;</span><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; mca_funcs &amp;&amp; mca_funcs-&gt;mca_set_debug_mode)</s=
pan><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span><br>
<br>
<span class=3D"elementtoproof">We should check RAS in_recovery flag in such=
 case. Reset domain is locked in relative late phase, at least *after* erro=
r counter harvest. Please double check.</span><br>
<br>
<span class=3D"elementtoproof">Regards,</span><br>
<span class=3D"elementtoproof">Hawking</span><br>
<span class=3D"elementtoproof">-----Original Message-----</span><br>
<span class=3D"elementtoproof">From: Zhou1, Tao &lt;<a href=3D"mailto:Tao.Z=
hou1@amd.com">Tao.Zhou1@amd.com</a>&gt;</span><br>
<span class=3D"elementtoproof">Sent: Thursday, October 12, 2023 17:01</span=
><br>
<span class=3D"elementtoproof">To: <a href=3D"mailto:amd-gfx@lists.freedesk=
top.org">amd-gfx@lists.freedesktop.org</a>; Yang, Stanley &lt;<a href=3D"ma=
ilto:Stanley.Yang@amd.com">Stanley.Yang@amd.com</a>&gt;; Zhang, Hawking &lt=
;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;;
 Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd.com">Candice.Li@amd.com</=
a>&gt;; Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Chai=
@amd.com</a>&gt;; Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@am=
d.com">KevinYang.Wang@amd.com</a>&gt;</span><br>
<span class=3D"elementtoproof">Cc: Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zho=
u1@amd.com">Tao.Zhou1@amd.com</a>&gt;</span><br>
<span class=3D"elementtoproof">Subject: [PATCH 4/5] drm/amdgpu: bypass RAS =
error reset in some conditions</span><br>
<br>
<span class=3D"elementtoproof">PMFW is responsible for RAS error reset in s=
ome conditions, driver can skip the operation.</span><br>
<br>
<span class=3D"elementtoproof">Signed-off-by: Tao Zhou &lt;<a href=3D"mailt=
o:tao.zhou1@amd.com">tao.zhou1@amd.com</a>&gt;</span><br>
<span class=3D"elementtoproof">---</span><br>
<span class=3D"elementtoproof">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.=
c | 18 ++++++++++++++++--</span><br>
<span class=3D"elementtoproof">&nbsp;1 file changed, 16 insertions(+), 2 de=
letions(-)</span><br>
<br>
<span class=3D"elementtoproof">diff --git a/drivers/gpu/drm/amd/amdgpu/amdg=
pu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span><br>
<span class=3D"elementtoproof">index 91ed4fd96ee1..6dddb0423411 100644</spa=
n><br>
<span class=3D"elementtoproof">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.=
c</span><br>
<span class=3D"elementtoproof">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.=
c</span><br>
<span class=3D"elementtoproof">@@ -1105,11 +1105,18 @@ int amdgpu_ras_reset=
_error_count(struct amdgpu_device *adev,</span><br>
<span class=3D"elementtoproof">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ras_block block)=
</span><br>
<span class=3D"elementtoproof">&nbsp;{</span><br>
<span class=3D"elementtoproof">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct amdgpu_ras_block_object *block_obj =3D amdgpu_ras_get_ras_block(adev,=
 block, 0);</span><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const =
struct amdgpu_mca_smu_funcs *mca_funcs =3D adev-&gt;mca.mca_funcs;</span><b=
r>
<br>
<span class=3D"elementtoproof">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (!block_obj || !block_obj-&gt;hw_ops)</span><br>
<span class=3D"elementtoproof">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span><br>
<br>
<span class=3D"elementtoproof">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!a=
mdgpu_ras_is_supported(adev, block))</span><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ski=
p ras error reset in gpu reset */</span><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (am=
dgpu_in_reset(adev) &amp;&amp;</span><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; mca_funcs &amp;&amp; mca_funcs-&gt;mca_set_debug_mode)</s=
pan><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span><br>
<span class=3D"elementtoproof">+</span><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!a=
mdgpu_ras_is_supported(adev, block) ||</span><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; !amdgpu_ras_get_mca_debug_mode(adev))</span><br>
<span class=3D"elementtoproof">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span><br>
<br>
<span class=3D"elementtoproof">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (block_obj-&gt;hw_ops-&gt;reset_ras_error_count)</span><br>
<span class=3D"elementtoproof">@@ -1122,6 +1129,7 @@ int amdgpu_ras_reset_e=
rror_status(struct amdgpu_device *adev,</span><br>
<span class=3D"elementtoproof">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_ras_block block)=
</span><br>
<span class=3D"elementtoproof">&nbsp;{</span><br>
<span class=3D"elementtoproof">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct amdgpu_ras_block_object *block_obj =3D amdgpu_ras_get_ras_block(adev,=
 block, 0);</span><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const =
struct amdgpu_mca_smu_funcs *mca_funcs =3D adev-&gt;mca.mca_funcs;</span><b=
r>
<br>
<span class=3D"elementtoproof">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (!block_obj || !block_obj-&gt;hw_ops) {</span><br>
<span class=3D"elementtoproof">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg_once(adev-&gt;dev, &=
quot;%s doesn't config RAS function\n&quot;, @@ -1129,7 +1137,13 @@ int amd=
gpu_ras_reset_error_status(struct amdgpu_device *adev,</span><br>
<span class=3D"elementtoproof">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span><br>
<span class=3D"elementtoproof">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
</span><br>
<br>
<span class=3D"elementtoproof">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!a=
mdgpu_ras_is_supported(adev, block))</span><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ski=
p ras error reset in gpu reset */</span><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (am=
dgpu_in_reset(adev) &amp;&amp;</span><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; mca_funcs &amp;&amp; mca_funcs-&gt;mca_set_debug_mode)</s=
pan><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span><br>
<span class=3D"elementtoproof">+</span><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!a=
mdgpu_ras_is_supported(adev, block) ||</span><br>
<span class=3D"elementtoproof">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; !amdgpu_ras_get_mca_debug_mode(adev))</span><br>
<span class=3D"elementtoproof">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span><br>
<br>
<span class=3D"elementtoproof">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (block_obj-&gt;hw_ops-&gt;reset_ras_error_count)</span><br>
<span class=3D"elementtoproof">--</span><br>
<span class=3D"elementtoproof">2.35.1</span></span><span style=3D"font-size=
:12.0pt;font-family:&quot;Times New Roman&quot;,serif"><o:p></o:p></span></=
p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB7988F397C68AFC16AD059D959AD6APH7PR12MB7988namp_--
