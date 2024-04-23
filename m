Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4780CC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 06:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D7410EBA2;
	Tue, 23 Apr 2024 06:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EmEHaVgN";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE2110EBA2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 06:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czbykS86gGCa9Noj8i83fqM6Q+KvHPlXQ1bcK46g+iAumKJIt/tFeqDSsiE7KY1rmTx7J5BL/bjn09v4suEV8PFpTw/LtWHSR64u9CJZ08aspWuW/PrdH07wG50NjXju+LYfiz7wkgOY6smLGDVLMrsqCwVbLhFQhCObEVwGZh+fPRycVv7gtMh0edtiyi8/OW+pilGp96SP7geg2Wm/OTunxUlCqpdydTcp3vILZCf/WRytjsxfybREGvHjGK9++D7AucReYBRN3cNOD/GJ5JHbj9KFMC3WVwkFlPFPqLG2RQOhUjM6/bA0Iwe00zZ5//9RvZvJir8SJTrZDESh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsNAkjz3K8crwSNOfuhisl0CyyODoF7Nc2ZOCfKJmU8=;
 b=PEBIOzwn4sBKMcQetpxuH3zM7gJYVzDydBJ+uj6Ev/PB3hi7xZ7Tu8POAUG77EFKbT5pI2Lwe3EUPkAAhzjjnjebdjQ7mlv4sIC8W8GmUo8uUV0Ym+thlBObhfxG1hTjWCoJv7MkjWR1rtmf09fzkw1XI2gfq1ZIKBy/AvS6SzJbg1nuL3+usCM0ejjMJTHj1a0ZVGNMsRRy1rieM6kRzCEIKtvHI0ePYZR4f0bxc76KIpwq0fAW0ylb5XKCU4XQ9fVGbr8gsN5A6Nzs69a2GAjCQRR7IZ3Ajbhy+70/pnMCC4jSI878gkC9hm5j6UGgTcD99J3W6+BD4I8aWNWaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsNAkjz3K8crwSNOfuhisl0CyyODoF7Nc2ZOCfKJmU8=;
 b=EmEHaVgNNMR6JFs/seNcwuiYfHoTzUWdsh8vux94pYwn9XQAhlfEoh85Dhy2AZ3itwiU0DIyEBqrSpktqJXEXTrxNoDFOxlpJXUceuSj8S4k1/oRX6/o0DFzCW/2Cj/Olm4DLf+SjYaqdMpZm32OC78McRjhMYQ/6Vh3BoNIUWQ=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 06:08:01 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 06:08:01 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix ras mode2 reset failure in ras aca mode
Thread-Topic: [PATCH] drm/amdgpu: Fix ras mode2 reset failure in ras aca mode
Thread-Index: AQHalSxkwfHHu2VyQ0yl4uwS5lcF/rF1Me4AgAAs4iA=
Date: Tue, 23 Apr 2024 06:08:00 +0000
Message-ID: <CH2PR12MB42159FC0B664DD50097F4802FC112@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240423031338.863302-1-YiPeng.Chai@amd.com>
 <BN9PR12MB5257AB4F001E4DD0ABF03044FC112@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257AB4F001E4DD0ABF03044FC112@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=75908d74-f3ae-4462-b50a-440cadcd8adf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-23T03:26:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|MW4PR12MB5601:EE_
x-ms-office365-filtering-correlation-id: bbe295ee-c2a2-43ee-5fd3-08dc635bbaee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?/FttPbfr/h4Kogkj8foJm7SRyq7B5cWsHsYKW0Mh6s5XrFgcGnO/0FBl77qv?=
 =?us-ascii?Q?x8ewTEqFr8eyhx7J8vxXmy2ye7nK1Hax8uKGWIWaClqWq37cpCoZJuy8npKO?=
 =?us-ascii?Q?XribW16yPVAMi3sx8lDXTAhsrVSKG1MNROZPSvAeljaFrd4w9oX58ygL61Ur?=
 =?us-ascii?Q?EKqew5vh9h/4p12xgeJiM2q/Get5BqkPBrQ9OVDiDzTX8bTy4k+DL2jN9cPD?=
 =?us-ascii?Q?yJigHmUyR/dL/NTfaWq3BZdjsi9hoSZhwJMV6NGgd483iNv+VJpmYcRMXvSL?=
 =?us-ascii?Q?vLjbPuJCJvcXWmwXEJxDwlWrWA//WYmGYM9+1z0Z37NHIQ5XU+sO03t4ELo5?=
 =?us-ascii?Q?CCwitTDxBWxsF+iihfBNgdwgt+ZNJnEfhsN82HkmzXHyac81w5qpWehcpqiQ?=
 =?us-ascii?Q?L1cRJf5ai7tWQHUCjawhyCA1e5GQK2PFuhNgADKnC06rIqxPAlYmO3aCAox4?=
 =?us-ascii?Q?dZYFryL7dxOAU/CHRrfPf4+1ky/m0EcraJ9+KDi1DPRecM8MCId7mr8Q0LeZ?=
 =?us-ascii?Q?izsQL9/I4yshIONHQAezDs7uH4usMSlCTavcnNWUETHWR3AewHWPhtnSGVPW?=
 =?us-ascii?Q?FNNOT/BDE52qfsp8AU+i2jEcSyvdRoXO3JNZniEMKh8D07HK7PYIrPEJ5sCD?=
 =?us-ascii?Q?tgXY9Lb0Ani3OFJq3ZZkB0rVuZLfbXFAygYOzFKaXwgxmWOxMTKCYeb7zbR7?=
 =?us-ascii?Q?Pn5hX1tas6vJQPkvrEXO9KXMtcnvyrVPfTPyKzQTW+fljlacC47yQoNnWItZ?=
 =?us-ascii?Q?Q7QBe+2ShrIR3TIpoowyxgpWDXNaoRlgcub0n4VJgwMjbbhMiNnk3nDV+BMi?=
 =?us-ascii?Q?Dp/MTVMpFnt7FoptscQfW9EcjKhLEUmRzUCzL7IRFDDOfhnSQuhbFP87Sj1V?=
 =?us-ascii?Q?N5FyChv7DtdRysD5laswkl11c3vdZ5z6BCJD9+IdHZ5nCDAC1dxk1+gkEOUM?=
 =?us-ascii?Q?Y+rIdU6YGNPI5k6fqH/kGaCuZBncC75NlRJ3Agbe7JdoOBU/+YDd5GUzkWa5?=
 =?us-ascii?Q?5XbzEA2NwqhDE2gOFZSQf4a4rnQc+GHIb03QihiZV0Kp8XJyHSkUbSBpjQVx?=
 =?us-ascii?Q?j8BALQyMvcYInQ+EZkoDn10ROAznKSkQRKUn/lsWdwE4b4MDlJXabbp40bkI?=
 =?us-ascii?Q?7mCI09X0C5ykqSm97QFsnEAO0FOEzf1YWHgD+0jRCrzCJRD/40QCtXN3SkhK?=
 =?us-ascii?Q?4xkLWjFohbCLAtOgSYiGJeTRLJp6HaS29g+OUjEyZsYvHOafQZ9vzTwo0DAE?=
 =?us-ascii?Q?PmQcL272Jj1mwi43UmZx76Jer7dcNKTfhH5VtDaME+MwBv03514RAB7d3qex?=
 =?us-ascii?Q?D2ZqQY401QW+ID6+KTIwXtNqRZdV1fQL1CJqeabuNmoEgA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4BgESs3b54Uuh4zTorXh+yUJRnZ3rHeNNei5aYwYI22OHZ6bdFmH2/3TtUNT?=
 =?us-ascii?Q?SyqX61G+4YfVRatRC/9SvLc9lCMtOrP1A8kOq6nch8RWDj6lJ7KF8ZdSzSfZ?=
 =?us-ascii?Q?AEkAnVfUSOK1sS1EfCcr1ENL3/qhaZyG5Q2BIuMPD/Dr92ROqkGYW0YcEi62?=
 =?us-ascii?Q?UP4upcFiUkRuNHSCisGUjfdXWEQ6S5A+Qotmpr6bLIgyLpTlWqcnr6PeG8dT?=
 =?us-ascii?Q?S3AoRWk3rtLPQBrJxGIiUEvaOeY0DyaTZGJW/BSEvkLw5VXm/jJxyr8khBfv?=
 =?us-ascii?Q?eo+Ao0pj7rE1s2auHMTAIKlN0HCx4O+wmFJ2gWTpAUm5Hpf6aGT+CgaCXbff?=
 =?us-ascii?Q?+7OoJpLatkd2AWMyDsXZIlyn74lK8cKTUGXEvW93z73FarKXppVxhwHm/QlZ?=
 =?us-ascii?Q?ScBjN5LFVOgCVbRHN3ANMF2Zh4r+aywY+om8IIkKgRCj0gBh5+ENqi1x5nW3?=
 =?us-ascii?Q?+wnRye/VijYVqgwrZumDPUVcKXTf82ieZJHmrJEmJ3RJoopghNmCxOwSBja3?=
 =?us-ascii?Q?HlI/gzfXfX1JRkq1Z+vt5vWgNdfZIUEbC2FU3NpAfpzzxmpE4aQO/JAeFphM?=
 =?us-ascii?Q?7Vw0JRubNxY3tckjCyscm39R2ta+fCWYrolQFJxT+0/jo8aUF6w7F6xwMzHn?=
 =?us-ascii?Q?zit8GG6scSdHhosUpdqH9mqICDFCljRXcK4FjEKuU2bEy104LPkQtCJovkTL?=
 =?us-ascii?Q?aE9p0bDHRKZoTYi1U0Lyd9LNtOJK76I3sIKqNheO1ozHFgHgXzagKjXlC8w9?=
 =?us-ascii?Q?/2eNphCmKNEWCgQHsGldwsV1YZNLq5tYMFECh/HpmkKCrcutyz6Za4zolEmP?=
 =?us-ascii?Q?pMYOMWJ3n9Mms4gBp499dG8nYt6/8GgpMFKi0V2+gxoIovdAESdTnQ4+bOEO?=
 =?us-ascii?Q?P8vDBDwG4JaUdhgVNh71u+2f/RCMAsY9dUoXJA9Y182UZbK2Vt621CclGIut?=
 =?us-ascii?Q?iKXnQHxFffTIA8K+jO6Bt6O9qfqhOL0rFTHN1ScmUjbFP+pLbLqo535CPQNv?=
 =?us-ascii?Q?ZC1sZqcZ/Dik53SVaJLbU0+xSaRe6+tj51a7KjI4bNqlAuDDbYRTYMwHSIHy?=
 =?us-ascii?Q?n2ZJ/ImeV47Whs3WHl/Lf9DOl01rFA3JM5y5I9J+nSvswoRaAI0Yv+nJ2+Pk?=
 =?us-ascii?Q?HQs+STym8WNYHJg/cIHoHw4x/DbLiPJx4wFhawkd3jyIb+XaRBLrKrAp7ApH?=
 =?us-ascii?Q?62k+haZ0fCqNKBHpL3qTdWLC/hqOBF4v/slimV/QdSHvUVtZF7UQYdjzZUPp?=
 =?us-ascii?Q?9V8aeBOFZklNWnZgnhphARLUgfmJ4U1IQbvts5HhN5zFKGhM1qnMfrneFox1?=
 =?us-ascii?Q?8aR8ryf4gyzCjHsds38pNRtIDXQYiU+MggQL9BKnTfSibxBhmGwU5++CXefT?=
 =?us-ascii?Q?LbFMF8Ix5C2YAmpGR34mluiTY9I9TD/Q0AN6Z6uT1MJvZIawvED9+hB5rF+6?=
 =?us-ascii?Q?Z3l9rHWRy3dMLCLemN/XqjX6fg6+AsywU0s61u8ajnAXt4FLi4PKEj5W5Gll?=
 =?us-ascii?Q?CKGE2ouusNRl5HvYkW/pLX+owfy3PUjR7XYJQv5ZQKIH8uV30MYyWpPDi/6W?=
 =?us-ascii?Q?t4kWrDGkj/L6tbd9Z/I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe295ee-c2a2-43ee-5fd3-08dc635bbaee
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 06:08:00.8509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPreX/f35bq9dkvEMHrUpV4WL0dZw1QoxFv2McISamHm74iMSc5xvMS/aVE0q2ELjfTlbDPlmI5oP7a0gT6grA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
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

[AMD Official Use Only - General]

OK


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, April 23, 2024 11:27 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,=
 Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix ras mode2 reset failure in ras aca mod=
e

[AMD Official Use Only - General]

Shall we move the check to the aca helper function?

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Tuesday, April 23, 2024 11:14
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Fix ras mode2 reset failure in ras aca mode

Fix ras mode2 reset failure in ras aca mode for sdma v4_4_2 and gfx v9_4_3.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 4 ++++  drivers/gpu/drm/amd/amd=
gpu/sdma_v4_4_2.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 0e429b7ed036..c8bc34aafdd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4324,6 +4324,10 @@ static int gfx_v9_4_3_ras_late_init(struct amdgpu_de=
vice *adev, struct ras_commo
        if (r)
                return r;

+       /* in resume phase, no need to create aca fs node */
+       if (adev->in_suspend || amdgpu_in_reset(adev))
+               return 0;
+
        r =3D amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__GFX,
                                &gfx_v9_4_3_aca_info,
                                NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 7ea209b68154..77ae943745fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2249,6 +2249,10 @@ static int sdma_v4_4_2_ras_late_init(struct amdgpu_d=
evice *adev, struct ras_comm
        if (r)
                return r;

+       /* in resume phase, no need to create aca fs node */
+       if (adev->in_suspend || amdgpu_in_reset(adev))
+               return 0;
+
        return amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__SDMA,
                                   &sdma_v4_4_2_aca_info, NULL);  }
--
2.34.1


