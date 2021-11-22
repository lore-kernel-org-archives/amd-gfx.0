Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36F8C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 19:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A1A789834;
	Mon, 22 Nov 2021 19:58:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1176E89834
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 19:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QePy/tvMsFD+ApMGYcP7GlDQMLHoWoejfdBIQYMyWdnWGh7KHOJPHb04Jb0KWmq2vRV29Opy+ZH3EeDyJ8niwR/TdlLvr4AJV1Mpm//QL8otHUoYfx8nVTXZip3hySMLps5BOU/PcVqauADU5T9IplB4eUxnY52eTxCHL9LSHuTbyMqRBEv6ZLE+tx4swRB4jialhiTvKGz5tDVWTNa7Z6f37SGbs6cTvTysYPFZcQe5KCkX6OqhVAF8Ug/G8pdo0/YzGD6rAFYo3Ux/DboFDjjVDvz8Gnk6mmGZdhZfoULpUIGKHZIvRbZlNzYAaBdr7whbs5FBQj3FA9gky7828A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/h1s95YjeY8syF218Z86Fa9p0qWGPQPfW5LoXIQkiM=;
 b=XjgRnlYYV39AExsF9FtYrDT0cCBXcm2FjCG6FbR73sXIfSoePasYvSJiT+Iyen9Y1HlOHTD5r0xH9zyLVhev1y8gQHmBlEbZxE0z0SomEeZU6T/W188I5fSrLi9nglB1YlPrGvlY1Fgp+5oxIxbCyjt6AitWoEq9xy3EW0beVAwbiLb2iyDzfOeDLGQGxFE5ZLC/Nm4ML2xTPr1wM1RqMdVL1GaF2qS9v8pUoWWGuolo0ao4+spn69AamUCnztGJpjmVBpyC83x/bOrzsKn9BtXs6dVXfdHInHRh+iUkteeEIwGBuLEUx7JMLaTv/qfGsRKedlBk9lazCwqvgfXfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/h1s95YjeY8syF218Z86Fa9p0qWGPQPfW5LoXIQkiM=;
 b=aahVjVCAKaX2EZc1tuVHN/WDFzBfP3vdy+XvDlX6rWKofSDNUTcuzNXJFcxh7PW+pt3T3B+3mFOo40Hadi+ryi4eBwYrrnFKfp7NDnTblT2t4NBXe/sxSa3sg1plEAd6mICC43VWcWYjXmzg0HXzvA7Jl9qYW1KljxdgI76LKEw=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 by SN6PR12MB2765.namprd12.prod.outlook.com (2603:10b6:805:77::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 19:58:29 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::dc61:1d3f:e774:5589]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::dc61:1d3f:e774:5589%6]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 19:58:29 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Declare Unpin BO api as static
Thread-Topic: [PATCH] drm/amdgpu: Declare Unpin BO api as static
Thread-Index: AQHX3MlWNa/Z9mB05keVSNUAEQtFQKwP/Pjg
Date: Mon, 22 Nov 2021 19:58:29 +0000
Message-ID: <SN1PR12MB257578DF2A2958657B71FF00E39F9@SN1PR12MB2575.namprd12.prod.outlook.com>
References: <20211118221154.31176-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20211118221154.31176-1-Ramesh.Errabolu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-22T19:58:09Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=516c086f-7742-4fbc-9e23-2502f20ff507;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-11-22T19:58:27Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 89510ec3-9cb8-4d96-a35f-bcf2b903f7d9
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98c08bee-f21f-482a-b8a8-08d9adf27464
x-ms-traffictypediagnostic: SN6PR12MB2765:
x-microsoft-antispam-prvs: <SN6PR12MB2765558F4186BED9572D348CE39F9@SN6PR12MB2765.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wsWmIxIfvch7eQbkWU2ER06XAi3+plF/9LiL7dng6GK8wvgGiUonXVkE4y/eRn72n+TI5+Iq/xKnMkVXRARZgv01SXqwiW+IvHJwI8W8A7/Z5L0Q2XhFuUO7hv6AqgKFIri9S3g6Qz97YjhayfgcjG/qL0N5pqb80aRRcWUhZN/BZqxCjlu/hH7TulfiIH55mo5Cpsnbfsoi6YUpCm3L6Kqb87KyH1aw7iuphEdkHQ+VY7aS692OyhgUGBMR5wJtFldNtChKhlYW2wRXCxYJRF2w1CsEBxlrP9vUiMATF2qu+hzSUUckwpFa2EEvh6OmN99I872zBwg4VkdglGqZUJgGPf9fHmPbE6olXSHDt3uJhbIR8CgLtZB18D6FoE8/cKeP3zICySIF8P0IKNfrG0SjLkO8kzGf0WKSDs6y9k00XCQOxRxAERkhDniJkCKocA8HDgNA+4mQIZyAqRA7MaxzJHEijxDl9DsQyNYLI0Jbum7kOowNqz54nASLubETbCYJg4c8nzLG3DxgR3DzrUSShnmCaHEHSJW7Dry/A3H0hpdEOfqJpx9NL1Nl4CVbUx6J0K+PLho+WPeTuhgXxYq2DsLIDrx2CVsGibkg7Way9ShYE5yEjUgnhbkC5UHXe6zwK+jNY5oXbBi9cmQPt2VCnLyrjls7jtv6iii/cH12lrnP05D8rZ3ZssQ6bqdQGFWdLewdWiqv3j9d4XcuIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2575.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016002)(71200400001)(186003)(33656002)(7696005)(52536014)(64756008)(9686003)(53546011)(2906002)(316002)(66446008)(8676002)(5660300002)(66556008)(76116006)(110136005)(66476007)(38070700005)(83380400001)(6506007)(4326008)(86362001)(26005)(8936002)(122000001)(66946007)(508600001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dAUVfNS4PtSoi049VFQ9Ztrn8MRhMMWxD/UR86FQb3rXqlKzRVSC8ZVhto12?=
 =?us-ascii?Q?BRWPU7FUIGxR2uXgID8ztg1Vc3RnMPMvr2i8JrLFsdYA5QjrsNShzFlD/wJ7?=
 =?us-ascii?Q?yFklamAwGfE/W3Q9y1brrZPTjG8z826LYr1OyoFB1mloeeIuLgHUmW0LJsVP?=
 =?us-ascii?Q?mIWMrAAoHEcw5QHC3qQJaCrE2MXzEYpBQSKX/0BNYtqfr1v4yzq2+Ubl5Rur?=
 =?us-ascii?Q?30oXaFZ7O4ixiZ3idMUTZBd6Nbsw9QRWT1e39RRzwbmO94foDzshq3lak/LU?=
 =?us-ascii?Q?3g1LLpB/H0+gepnFa2CEfp6a2kcD5/CCjKb4CV08MoFCQ6LBUcj88kyx3Qpr?=
 =?us-ascii?Q?Jh4q0NE4PrXDbvAPEkrVwSOTahQi8QGGWTprwegfKpSIv1DCbPWsmfhwC9qq?=
 =?us-ascii?Q?3SGq8AV289J+XletdXOlK4iYtPSK4fZLpAd3yuug09IojkOHoHvKcaxMU57n?=
 =?us-ascii?Q?As6qGUM6Ap4bewdrGg+uy8NnZex96DYnrtFYLOOWHGHyEX1c2C8Jfp/szHXj?=
 =?us-ascii?Q?6CqMDkFcnlIRoEq1VQsTuG3PuyPnIRr14hRIibsAao4knXO/7vEu7UUe7IK1?=
 =?us-ascii?Q?wfCWigx0sKxpeaXt7EI2F8krjd+zOi1PLFgC72KZlbqU8bwmeLMOjCB+FECY?=
 =?us-ascii?Q?KSwSaO+2CF5Aqz3Txvh3zQAFyOIxRo9/hcZ6kzF0Q3kSPPlzwL1USX0i62Fa?=
 =?us-ascii?Q?1R2CgXRaEFerS10vFeWZDV7ynp4hKUa2zXVnHZKp+c+prDzM5mCMOzVYLEBs?=
 =?us-ascii?Q?0ylkvbMaXKSZ+OyDtZWs6hyQ6KexhQNHzOc3oJIvBG6sLk2IQaOCxCwvsI9/?=
 =?us-ascii?Q?/rRlWs/wZb1ar4nlPelmHeJjW27Q5RNHK3TqKtRMDK18XeIW7OIj1uER5mR9?=
 =?us-ascii?Q?A/cwp2kHZ5PjnERXIRmOspnc6KfK6dh71sivbo2aYBRt6uLeRa9D0z53Z3Sr?=
 =?us-ascii?Q?XNfciDigaOf85Fgv+YKAeOGYkhjJo+SZxKTF+SEPQycVfF9XegzyNp70QOB7?=
 =?us-ascii?Q?JSZX3/DQ9dqDn3U6A2LPJogf4rgB1xGaTK6fSgM8Sgx4dkVKNUeZW23Tpv6s?=
 =?us-ascii?Q?3DaYTx50+QgvRfR1CpppkP9xV9sPHZqKihYiRYnA03S4tuw2BmP+NJ0zFSgv?=
 =?us-ascii?Q?nv4gQWliWsJpMiSPWz/MbuA5ryLK4C7bx0CQg+MpSIGruj3mTMXw1ougBVik?=
 =?us-ascii?Q?0ks9O4Absm/AZWwiN3IpaeFCWxWVZjAxx71Lw50udkbZg6Pv00yMRKsERWDj?=
 =?us-ascii?Q?eaqh+38o0sd1mKrLNEBHWHFfrMJvM1qoYO67VqBH4dP4OPHrfXcjpQTVEYn5?=
 =?us-ascii?Q?3WqesW8NsQZnLV0YAKFNWtCDWlxGz0GWsqZ3gXtw5H1lPuDvkT4ZZRT3Yc9b?=
 =?us-ascii?Q?jWslsi+DsA+1SVbi+PQD2xzvw6QBHHfx8TaMUm7jm7A2wZ3buikoT0OelDOw?=
 =?us-ascii?Q?NJGB9RNnvFoRqlUa/MMCP5eilAqQGGCdjeswO+dvxMmE+i2wTMu11qlm5TiW?=
 =?us-ascii?Q?u63pQR6mSxP6e7S2MunGh3KUBSr80dfZjm0s/+TRacUPdvCNEkVrAXh52ebT?=
 =?us-ascii?Q?p595IxdFP8elMsCJSwUw4iHAnpRAcYZH9HUr06CmlByivkx2VDy3yb6kJwqz?=
 =?us-ascii?Q?gRIa4dAIO8OsmzuYmUCcRFg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2575.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c08bee-f21f-482a-b8a8-08d9adf27464
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 19:58:29.4745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fcm2MbvoGWP25iYCHVuSulSBXkfkpGSUgvY0anqeUY8ruD1FUIF8NzCY2llbpDZFHU/rUmf3rkQBvCVWWAWSyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2765
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Request review

Regards,
Ramesh

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ramesh E=
rrabolu
Sent: Thursday, November 18, 2021 4:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>; kernel test robot <lkp@inte=
l.com>
Subject: [PATCH] drm/amdgpu: Declare Unpin BO api as static

[CAUTION: External Email]

Fixes warning report from kernel test robot

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 90b985436878..3463e0d4e5ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1332,7 +1332,7 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_b=
o *bo, u32 domain)
  *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
  *     PIN count decremented. Calls to UNPIN must balance calls to PIN
  */
-void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
+static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
 {
        int ret =3D 0;

--
2.31.1
