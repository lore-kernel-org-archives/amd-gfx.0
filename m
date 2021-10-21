Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE56C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC9C6112D
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DAC9C6112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EACC6EC7B;
	Thu, 21 Oct 2021 14:04:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D827C6EC74
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 14:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0kavC+rkYEXdcJBbv6GGk1286HkLM//9FoW7AT5KmmQCGUQlIrFDm1sekHYhpKSExERR2I5Otoh0YKLg29fXU745CNMioFXaCj3fTQrS7KB2gRx5SF6IDgN/ayFMo0PLLcEM3w3FNvWEVfTRfsISk5Ez09NN1pNvJuL787Wub9EZKaXyPWXrTy9eIoHKULAVak+4IyZwJgceqWYhq1XDM8DINCAFJFadH7EYHEc+BmHnFVCRl8I7dZRum0JdtyqsR1NLL4Mdxu9iHcbYVpxLiZ8WdUDI/gZjf9WeBNzx06uLh2TJMtxpfb33YEQKS0V+SUIFTNArcqNp24mXPK+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbAdKNwHqdt4efHwCKkzJxL9xheYdg7wiP9X9zVUxW4=;
 b=llmnAAscX4m/hwriTiL8H82Q2rcB1bjVbC7ZbJaldhQUW4ICMyINNNsBAVV/K5rJjfmNqr/SoMNYwbjY6fsU4ckFw+0+s9nNacVV2xjfjh9Wai3eOxI2VX8khm9Vq/zaSPqcjuTA8tZI+4RFW+1pBSlJw/z0Wpg2sIfkPZ9LkrInnKP7rUMnSHw5o62/cuTepBpwCYwqqGRT0tqpnYaySS+dZwdC7w4i+EzqpdsvRl8uWpAtgVpSgX49P5Gs7XwsVIAqQZ3AJc3YF01Yuzp7LwiJS+u6Gpm6u6710fHJxWstTDKpGe58HxCVxoS9s7zaDx+DlJc748f8k88oArytiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbAdKNwHqdt4efHwCKkzJxL9xheYdg7wiP9X9zVUxW4=;
 b=qYVd1CJupMw0NF2DZA12gBXbGmmEN87A2h0zapivZtElxlxOTIbMsbphW6JdUAfuNttjXZmYdAtYjF06RZCq23hpcC44Pdbu+Nt70CLSmhEx5StJfACHbphfWNMlUHzp8ACXKeAwD8Q5LnHsFC4q/SCzR9FvOE52WGjxFih2Q+0=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM5PR12MB1769.namprd12.prod.outlook.com (2603:10b6:3:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 14:04:28 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 14:04:27 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: Warn when bad pages approaches 90%
 threshold
Thread-Topic: [PATCH 1/3] drm/amdgpu: Warn when bad pages approaches 90%
 threshold
Thread-Index: AQHXxdCCMswoPAunI0SMQFBOfGl3MKvcbJOAgAEPiIA=
Date: Thu, 21 Oct 2021 14:04:27 +0000
Message-ID: <DM6PR12MB332482A4DC91B5D767744E3485BF9@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20211020163520.1167214-1-kent.russell@amd.com>
 <ee745dec-ab0b-9ebe-3b79-dbc0e14808fe@amd.com>
In-Reply-To: <ee745dec-ab0b-9ebe-3b79-dbc0e14808fe@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-21T14:04:24Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=907340ad-e079-4286-9143-d47f12489e7f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a129949f-e1a8-41c2-3698-08d9949bb22e
x-ms-traffictypediagnostic: DM5PR12MB1769:
x-microsoft-antispam-prvs: <DM5PR12MB1769D411B7AD21680F98AE5C85BF9@DM5PR12MB1769.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wkugOjIQBpeXbKX9Mh/0nBFDeZCi5T+f8MkC+XI5C3rIpo6ieooY8aW3vSUNRFf8vuW8AypzBeKdqmIstF0J+ASdCmkigtS9O8mO9w9+HRjq91Wtt77eBVlM0Um6Ki5y8sKhi9raWpHormaQtlilejytY3M+HKBql9Nh2rU9wWIRWUwVnNBM3rSbjIdYwd1fDw+N9ehvAJRT1hEN2zyE+SK4nMpB/BA1uNuX2URXjmxJoF047YlS1HHWOrEZj9qZGQtJlUeU1fddVXP3mmeurjXQvdcZzYjXCxHQ1HB5KkHnzLV0/DQHTZTBsd51Kb7VQHE9JQQs8OE/bZ4OeArY8Wb0O9DHy8f27tU3ld/gMk6n2JoCcApCOo1DiR7uXd1ziNs8sSxpKgkl4ab4M2fN3bJsDR9lgnX9yXO2MtK1jZ4MJWRkahPRlAVVq0d+c2VAnPnn7By48qumj7y+pRYjnxDTxz5rTRLeyIhHCHbFndxsXdtKr+4UhmdCKmct/NkLqkBtddxSYcBjRYr9FRxmLMRfe3eGn3UHeRUpi+h0azZU78pgMkyrPBdXbvEUkHzDphCSymjF1qMdSfP/PbeKFNjzsIjMHbwKnoDfEA+419ixae/18SJ3SOf+HuLkxP08Epe6S89PyavjcKA3Gljp2OdBEQQQ+HJu+49g1F680R7LtpWIrQcKGDmIq1Qzbtxq1+x5kI7730OOgfuA+g0tjA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(8676002)(6506007)(86362001)(508600001)(2906002)(33656002)(8936002)(5660300002)(76116006)(316002)(7696005)(66946007)(52536014)(38100700002)(122000001)(53546011)(71200400001)(4326008)(66476007)(66556008)(9686003)(66446008)(4001150100001)(83380400001)(55016002)(110136005)(38070700005)(64756008)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?II08SJYoLiJx0KwDgk8IoOc3FMCfAjwJv97/o+kpkMqyQdjfFsujBSD+9IJs?=
 =?us-ascii?Q?guSBtsToW7OzxhqFsvCr6MyCZ1ajK50bwF1N84wTLRwfzupm7w6Lk8PU8cEA?=
 =?us-ascii?Q?yjx9WcP/yMPNlX529pd7UDLu/GUgA91tY9L0qCwD1v5OpE3X6AQKAPOFvTy6?=
 =?us-ascii?Q?bPpYyuW2LGVEmXOdFXMt+RZJGpOtF3ugozW+Cw6Xh2UIJpNSEbWcHNIBlZXf?=
 =?us-ascii?Q?qWDVkyy2dg5x4Muif10+wXTcK5p5Y+QXVpAOYc3TVJNGetr4+mZKiO9HGE4a?=
 =?us-ascii?Q?1voaq8Jpkh/PGHEDXtEzJUvDU6s/k2BEjnsX0kmWUlJgUdqzNXeRrzB7Cs8Y?=
 =?us-ascii?Q?DJK1ImOKEhDRoRtVFYeH0i/Q4xzjYCEYfuycQcQFMvzpZI39DQEDFhfcWchO?=
 =?us-ascii?Q?6m7lFvUqpr90ZyA69fkGm5UsKkzMMsDxDt3KlLB171dFfhzT6fQeAqDgAETo?=
 =?us-ascii?Q?qCKt3hpd5s1iiyRx7yD0gqGpPxhOg6+uhDrEl6D+bTrBtWzHh2+zAEwReFpc?=
 =?us-ascii?Q?WRtdRbaAopDA8bNo9SCkmj78Yqz7gp+jInkemfo6ZDb6/gMw+OeyO3Zov/XD?=
 =?us-ascii?Q?7//qW/1Vv7T7sDaz6BiSfLfOqUAFus8iSmG3Tsh0NTto/rlAnjOi3lrK566+?=
 =?us-ascii?Q?jnCYllR6JSFeQr0x8eoVxx4G+xnLAyn1rxHvaBDXD56DB1moRhZvTQWYbS4o?=
 =?us-ascii?Q?db9yGnHs/upcm7Or0v+U2SqCuShWMvTtA37D1m1DqIaW0S6FI3pKnzpHD/ng?=
 =?us-ascii?Q?eptnWaHXPfTDahQI3vCCPiyDgikuy4ojSPGtJE2MehewXFlL0PL23ONmdLKe?=
 =?us-ascii?Q?EX0jwvLaym2PAmlt6bjji6ZVcbq+PJGnK3MeuyzF3JPfp8Y/WUubwX/EUDWD?=
 =?us-ascii?Q?DLw2M7S7VL+P7imn9kap8XL4T7vefVmX+SZKGVpSOXKLb/MbP1+DgMVGpMtb?=
 =?us-ascii?Q?9FrZl4ZY4xN5UrxxK4vShbtpMLDWE6aTkIPcANbNTjFpf+80ygMKPwubYwgx?=
 =?us-ascii?Q?rHz+SPmA4aconWP0U9NTZ9pCZ2gSKHHZQoDFW+LJ9XTWT2qAz1HImRFz7tAT?=
 =?us-ascii?Q?h6eyDIysNeLpBYt3s8XhSOwI/a4+OLxhThD9scOPp+UcuRAEZwnKyby4PaIA?=
 =?us-ascii?Q?W9u/B9qfxhtCyb3e/dCAauJl8o/LH8Qe0mKr7k0NljYllh11nstCDC/5IAOu?=
 =?us-ascii?Q?Bk2G7VKUOEFlOPIXnRlWZi776cvZtuk6Umk8qrE1huJ+G+bExxfqWcPMGfNf?=
 =?us-ascii?Q?LC1rdb1hHXvCaKhW2++BTHNpXHb3lmDswDrqU4lKcVtv1yon3EncTILPp8x8?=
 =?us-ascii?Q?/ptUoUSwdfqJ5UN8I9mU9PREjAjMer12agHkA+i3dw0FzwmgTCywlz4r8lQv?=
 =?us-ascii?Q?D2i85B0Mz6xj+HMxhjmTDMEzibjW?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB332482A4DC91B5D767744E3485BF9DM6PR12MB3324namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a129949f-e1a8-41c2-3698-08d9949bb22e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 14:04:27.9211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krussell@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1769
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

--_000_DM6PR12MB332482A4DC91B5D767744E3485BF9DM6PR12MB3324namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

My editor won't let me reply in-line without making it look like garbage.

Thanks for the insight, Luben! They're all useful points, especially the co=
nsolidation and relying on the threshold_validation which has already occur=
red before we get to this point (which I should've checked).

And I overdid the transitive multiplication explanation, so I wouldn't have=
 to answer questions about it later. But your concise comment below pretty =
much covers things and shouldn't cause any unnecessary inquiries.

Kent

From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Wednesday, October 20, 2021 5:48 PM
To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Warn when bad pages approaches 90% thr=
eshold

On 2021-10-20 12:35, Kent Russell wrote:

Currently dmesg doesn't warn when the number of bad pages approaches the

"Currently" is redundant in this sentence as it is already in present simpl=
e tense.

Fair point



threshold for page retirement. WARN when the number of bad pages

is at 90% or greater for easier checks and planning, instead of waiting

until the GPU is full of bad pages

Missing full-stop (period) above.







Cc: Luben Tuikov <luben.tuikov@amd.com><mailto:luben.tuikov@amd.com>

Cc: Mukul Joshi <Mukul.Joshi@amd.com><mailto:Mukul.Joshi@amd.com>

Signed-off-by: Kent Russell <kent.russell@amd.com><mailto:kent.russell@amd.=
com>

---

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 17 +++++++++++++++++

 1 file changed, 17 insertions(+)



diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c

index f4c05ff4b26c..1ede0f0d6f55 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c

@@ -1071,12 +1071,29 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom=
_control *control,

        control->ras_fri =3D RAS_OFFSET_TO_INDEX(control, hdr->first_rec_of=
fset);



        if (hdr->header =3D=3D RAS_TABLE_HDR_VAL) {

+               int threshold =3D 0;

                DRM_DEBUG_DRIVER("Found existing EEPROM table with %d recor=
ds",

                                control->ras_num_recs);

                res =3D __verify_ras_table_checksum(control);

                if (res)

                        DRM_ERROR("RAS table incorrect checksum or error:%d=
\n",

                                 res);

+

+               /* threshold =3D 0 means that page retirement is disabled, =
while

+                * threshold =3D -1 means default behaviour

+                */

+               if (amdgpu_bad_page_threshold =3D=3D -1)

+                       threshold =3D ras->bad_page_cnt_threshold;

+               else if (amdgpu_bad_page_threshold > 0)

+                       threshold =3D amdgpu_bad_page_threshold;

I believe we don't need this calculation here as it's already been done for=
 us in amdgpu_ras_validate_threshold(), in amdgpu_ras.c.


I believe you want to use "ras->bad_page_cnt_threshold" here instead. For i=
nstance of this, see a bit further down in this very function this check in=
cluding the comment, in italics:

    } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
           amdgpu_bad_page_threshold !=3D 0) {
        res =3D __verify_ras_table_checksum(control);
        if (res)
            DRM_ERROR("RAS Table incorrect checksum or error:%d\n",
                  res);
        if (ras->bad_page_cnt_threshold > control->ras_num_recs) {
            /* This means that, the threshold was increased since
             * the last time the system was booted, and now,
             * ras->bad_page_cnt_threshold - control->num_recs > 0,
             * so that at least one more record can be saved,
             * before the page count threshold is reached.
             */

And on the "else", a bit further down, again in italics:

        } else {
            *exceed_err_limit =3D true;
            dev_err(adev->dev,
                "RAS records:%d exceed threshold:%d, "
                "maybe retire this GPU?",
                control->ras_num_recs, ras->bad_page_cnt_threshold);
        }


See how it says "records exceed threshold"--well, with this patch you want =
to say "records exceed 90% of threshold." :-) So these are the quantities w=
e gauge each other to.

Clarification on this below.





+

+               /* Since multiplcation is transitive, a =3D 9b/10 is the sa=
me

+                * as 10a =3D 9b. Use this for our 90% limit to avoid round=
ing

+                */

I really like the format of the comment. But I feel that the comment itself=
 isn't necessary... at least the way it is written ("9b" may mean "9 bits" =
or "9 binary". I'd avoid getting into arithmetic theory, and remove the com=
ment completely. Anything else (explaining the math) really distracts from =
the real purpose of what we're doing. (After all, this is C, not a class on=
 arithmetic--they who can, will figure it out.)

Perhaps something like:

/* Warn if we get past 90% of the threshold.
 */



+               if (threshold > 0 && ((control->ras_num_recs * 10) >=3D (th=
reshold * 9)))

Right, so here perhaps we want to do this instead:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 98732518543e53..2aab62fa488eba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1077,6 +1077,12 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_=
control *control,
                if (res)
                        DRM_ERROR("RAS table incorrect checksum or error:%d=
\n",
                                  res);
+               /* Warn if we get past 90% of the threshold.
+                */
+               if (10 * control->ras_num_recs >=3D 9 * ras->bad_page_cnt_t=
hreshold)
+                       DRM_WARN("RAS records:%u exceeds 90%% of threshold:=
%d",
+                                control->ras_num_recs,
+                                ras->bad_page_cnt_threshold);
        } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
                   amdgpu_bad_page_threshold !=3D 0) {
                res =3D __verify_ras_table_checksum(control);

Also note that up until this point of the boot process, we don't qualify th=
e boot by amdgpu_bad_page_threshold and I feel that this check in this embe=
dded if-conditional shouldn't do that as well.

Regards,
Luben





+                       DRM_WARN("RAS records:%u exceeds 90%% of threshold:=
%d",

+                               control->ras_num_recs,

+                               threshold);

        } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&

                   amdgpu_bad_page_threshold !=3D 0) {

                res =3D __verify_ras_table_checksum(control);


--_000_DM6PR12MB332482A4DC91B5D767744E3485BF9DM6PR12MB3324namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"ProgId" content=3D"Word.Document">
<meta name=3D"Generator" content=3D"Microsoft Word 15">
<meta name=3D"Originator" content=3D"Microsoft Word 15">
<link rel=3D"File-List" href=3D"cid:filelist.xml@01D7C663.06EF7FA0"><!--[if=
 gte mso 9]><xml>
<o:OfficeDocumentSettings>
<o:AllowPNG/>
</o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
<w:WordDocument>
<w:DocumentKind>DocumentEmail</w:DocumentKind>
<w:TrackMoves/>
<w:TrackFormatting/>
<w:EnvelopeVis/>
<w:ValidateAgainstSchemas/>
<w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
<w:IgnoreMixedContent>false</w:IgnoreMixedContent>
<w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
<w:DoNotPromoteQF/>
<w:LidThemeOther>EN-US</w:LidThemeOther>
<w:LidThemeAsian>X-NONE</w:LidThemeAsian>
<w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
<w:Compatibility>
<w:DoNotExpandShiftReturn/>
<w:BreakWrappedTables/>
<w:SnapToGridInCell/>
<w:WrapTextWithPunct/>
<w:UseAsianBreakRules/>
<w:DontGrowAutofit/>
<w:SplitPgBreakAndParaMark/>
<w:EnableOpenTypeKerning/>
<w:DontFlipMirrorIndents/>
<w:OverrideTableStyleHps/>
</w:Compatibility>
<w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
<m:mathPr>
<m:mathFont m:val=3D"Cambria Math"/>
<m:brkBin m:val=3D"before"/>
<m:brkBinSub m:val=3D"&#45;-"/>
<m:smallFrac m:val=3D"off"/>
<m:dispDef/>
<m:lMargin m:val=3D"0"/>
<m:rMargin m:val=3D"0"/>
<m:defJc m:val=3D"centerGroup"/>
<m:wrapIndent m:val=3D"1440"/>
<m:intLim m:val=3D"subSup"/>
<m:naryLim m:val=3D"undOvr"/>
</m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
<w:LatentStyles DefLockedState=3D"false" DefUnhideWhenUsed=3D"false" DefSem=
iHidden=3D"false" DefQFormat=3D"false" DefPriority=3D"99" LatentStyleCount=
=3D"376">
<w:LsdException Locked=3D"false" Priority=3D"0" QFormat=3D"true" Name=3D"No=
rmal"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 1"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" QFormat=3D"true" Name=3D"heading 2"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" QFormat=3D"true" Name=3D"heading 3"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" QFormat=3D"true" Name=3D"heading 4"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" QFormat=3D"true" Name=3D"heading 5"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" QFormat=3D"true" Name=3D"heading 6"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" QFormat=3D"true" Name=3D"heading 7"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" QFormat=3D"true" Name=3D"heading 8"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" QFormat=3D"true" Name=3D"heading 9"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 5"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 6"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 7"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 8"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 9"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 1"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 2"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 3"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 4"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 5"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 6"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 7"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 8"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 9"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Normal Indent"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"footnote text"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"annotation text"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"header"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"footer"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index heading"/>
<w:LsdException Locked=3D"false" Priority=3D"35" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" QFormat=3D"true" Name=3D"caption"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"table of figures"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"envelope address"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"envelope return"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"footnote reference"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"annotation reference"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"line number"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"page number"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"endnote reference"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"endnote text"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"table of authorities"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"macro"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"toa heading"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Bullet"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Number"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List 5"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Bullet 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Bullet 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Bullet 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Bullet 5"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Number 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Number 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Number 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Number 5"/>
<w:LsdException Locked=3D"false" Priority=3D"10" QFormat=3D"true" Name=3D"T=
itle"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Closing"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Signature"/>
<w:LsdException Locked=3D"false" Priority=3D"1" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" Name=3D"Default Paragraph Font"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Body Text"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Body Text Indent"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Continue"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Continue 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Continue 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Continue 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Continue 5"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Message Header"/>
<w:LsdException Locked=3D"false" Priority=3D"11" QFormat=3D"true" Name=3D"S=
ubtitle"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Salutation"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Date"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Body Text First Indent"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Body Text First Indent 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Note Heading"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Body Text 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Body Text 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Body Text Indent 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Body Text Indent 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Block Text"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Hyperlink"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"FollowedHyperlink"/>
<w:LsdException Locked=3D"false" Priority=3D"22" QFormat=3D"true" Name=3D"S=
trong"/>
<w:LsdException Locked=3D"false" Priority=3D"20" QFormat=3D"true" Name=3D"E=
mphasis"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Document Map"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Plain Text"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"E-mail Signature"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Top of Form"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Bottom of Form"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Normal (Web)"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Acronym"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Address"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Cite"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Code"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Definition"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Keyboard"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Preformatted"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Sample"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Typewriter"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Variable"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Normal Table"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"annotation subject"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"No List"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Outline List 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Outline List 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Outline List 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Simple 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Simple 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Simple 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Classic 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Classic 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Classic 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Classic 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Colorful 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Colorful 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Colorful 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Columns 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Columns 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Columns 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Columns 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Columns 5"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Grid 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Grid 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Grid 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Grid 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Grid 5"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Grid 6"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Grid 7"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Grid 8"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table List 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table List 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table List 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table List 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table List 5"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table List 6"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table List 7"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table List 8"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table 3D effects 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table 3D effects 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table 3D effects 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Contemporary"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Elegant"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Professional"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Subtle 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Subtle 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Web 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Web 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Web 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Balloon Text"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"Table Grid"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Theme"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" Name=3D"Placeholder Te=
xt"/>
<w:LsdException Locked=3D"false" Priority=3D"1" QFormat=3D"true" Name=3D"No=
 Spacing"/>
<w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading"/>
<w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List"/>
<w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid"/>
<w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1"/=
>
<w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2"/=
>
<w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1"/>
<w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2"/>
<w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1"/>
<w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2"/>
<w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3"/>
<w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List"/>
<w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading"/=
>
<w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List"/>
<w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid"/>
<w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Acce=
nt 1"/>
<w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accent =
1"/>
<w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accent =
1"/>
<w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1 A=
ccent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2 A=
ccent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Acce=
nt 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" Name=3D"Revision"/>
<w:LsdException Locked=3D"false" Priority=3D"34" QFormat=3D"true" Name=3D"L=
ist Paragraph"/>
<w:LsdException Locked=3D"false" Priority=3D"29" QFormat=3D"true" Name=3D"Q=
uote"/>
<w:LsdException Locked=3D"false" Priority=3D"30" QFormat=3D"true" Name=3D"I=
ntense Quote"/>
<w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Acce=
nt 1"/>
<w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Acce=
nt 1"/>
<w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Acce=
nt 1"/>
<w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Acce=
nt 1"/>
<w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent 1=
"/>
<w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading A=
ccent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Acce=
nt 1"/>
<w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Acce=
nt 1"/>
<w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Acce=
nt 2"/>
<w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accent =
2"/>
<w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accent =
2"/>
<w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1 A=
ccent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2 A=
ccent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Acce=
nt 2"/>
<w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Acce=
nt 2"/>
<w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Acce=
nt 2"/>
<w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Acce=
nt 2"/>
<w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Acce=
nt 2"/>
<w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent 2=
"/>
<w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading A=
ccent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Acce=
nt 2"/>
<w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Acce=
nt 2"/>
<w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Acce=
nt 3"/>
<w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accent =
3"/>
<w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accent =
3"/>
<w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1 A=
ccent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2 A=
ccent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Acce=
nt 3"/>
<w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Acce=
nt 3"/>
<w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Acce=
nt 3"/>
<w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Acce=
nt 3"/>
<w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Acce=
nt 3"/>
<w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent 3=
"/>
<w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading A=
ccent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Acce=
nt 3"/>
<w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Acce=
nt 3"/>
<w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Acce=
nt 4"/>
<w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accent =
4"/>
<w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accent =
4"/>
<w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1 A=
ccent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2 A=
ccent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Acce=
nt 4"/>
<w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Acce=
nt 4"/>
<w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Acce=
nt 4"/>
<w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Acce=
nt 4"/>
<w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Acce=
nt 4"/>
<w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent 4=
"/>
<w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading A=
ccent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Acce=
nt 4"/>
<w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Acce=
nt 4"/>
<w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Acce=
nt 5"/>
<w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accent =
5"/>
<w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accent =
5"/>
<w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1 A=
ccent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2 A=
ccent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Acce=
nt 5"/>
<w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Acce=
nt 5"/>
<w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Acce=
nt 5"/>
<w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Acce=
nt 5"/>
<w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Acce=
nt 5"/>
<w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent 5=
"/>
<w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading A=
ccent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Acce=
nt 5"/>
<w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Acce=
nt 5"/>
<w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Acce=
nt 6"/>
<w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accent =
6"/>
<w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accent =
6"/>
<w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1 A=
ccent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2 A=
ccent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Acce=
nt 6"/>
<w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Acce=
nt 6"/>
<w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Acce=
nt 6"/>
<w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Acce=
nt 6"/>
<w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Acce=
nt 6"/>
<w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent 6=
"/>
<w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading A=
ccent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Acce=
nt 6"/>
<w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Acce=
nt 6"/>
<w:LsdException Locked=3D"false" Priority=3D"19" QFormat=3D"true" Name=3D"S=
ubtle Emphasis"/>
<w:LsdException Locked=3D"false" Priority=3D"21" QFormat=3D"true" Name=3D"I=
ntense Emphasis"/>
<w:LsdException Locked=3D"false" Priority=3D"31" QFormat=3D"true" Name=3D"S=
ubtle Reference"/>
<w:LsdException Locked=3D"false" Priority=3D"32" QFormat=3D"true" Name=3D"I=
ntense Reference"/>
<w:LsdException Locked=3D"false" Priority=3D"33" QFormat=3D"true" Name=3D"B=
ook Title"/>
<w:LsdException Locked=3D"false" Priority=3D"37" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"Bibliography"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" QFormat=3D"true" Name=3D"TOC Heading"/>
<w:LsdException Locked=3D"false" Priority=3D"41" Name=3D"Plain Table 1"/>
<w:LsdException Locked=3D"false" Priority=3D"42" Name=3D"Plain Table 2"/>
<w:LsdException Locked=3D"false" Priority=3D"43" Name=3D"Plain Table 3"/>
<w:LsdException Locked=3D"false" Priority=3D"44" Name=3D"Plain Table 4"/>
<w:LsdException Locked=3D"false" Priority=3D"45" Name=3D"Plain Table 5"/>
<w:LsdException Locked=3D"false" Priority=3D"40" Name=3D"Grid Table Light"/=
>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"Grid Table 1 Light=
"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dark"=
/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"Grid Table 6 Color=
ful"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"Grid Table 7 Color=
ful"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"Grid Table 1 Light=
 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Accen=
t 1"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Accen=
t 1"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Accen=
t 1"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dark =
Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"Grid Table 6 Color=
ful Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"Grid Table 7 Color=
ful Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"Grid Table 1 Light=
 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Accen=
t 2"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Accen=
t 2"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Accen=
t 2"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dark =
Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"Grid Table 6 Color=
ful Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"Grid Table 7 Color=
ful Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"Grid Table 1 Light=
 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Accen=
t 3"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Accen=
t 3"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Accen=
t 3"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dark =
Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"Grid Table 6 Color=
ful Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"Grid Table 7 Color=
ful Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"Grid Table 1 Light=
 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Accen=
t 4"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Accen=
t 4"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Accen=
t 4"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dark =
Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"Grid Table 6 Color=
ful Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"Grid Table 7 Color=
ful Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"Grid Table 1 Light=
 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Accen=
t 5"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Accen=
t 5"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Accen=
t 5"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dark =
Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"Grid Table 6 Color=
ful Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"Grid Table 7 Color=
ful Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"Grid Table 1 Light=
 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Accen=
t 6"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Accen=
t 6"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Accen=
t 6"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dark =
Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"Grid Table 6 Color=
ful Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"Grid Table 7 Color=
ful Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"List Table 1 Light=
"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dark"=
/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"List Table 6 Color=
ful"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"List Table 7 Color=
ful"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"List Table 1 Light=
 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Accen=
t 1"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Accen=
t 1"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Accen=
t 1"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dark =
Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"List Table 6 Color=
ful Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"List Table 7 Color=
ful Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"List Table 1 Light=
 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Accen=
t 2"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Accen=
t 2"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Accen=
t 2"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dark =
Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"List Table 6 Color=
ful Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"List Table 7 Color=
ful Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"List Table 1 Light=
 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Accen=
t 3"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Accen=
t 3"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Accen=
t 3"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dark =
Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"List Table 6 Color=
ful Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"List Table 7 Color=
ful Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"List Table 1 Light=
 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Accen=
t 4"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Accen=
t 4"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Accen=
t 4"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dark =
Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"List Table 6 Color=
ful Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"List Table 7 Color=
ful Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"List Table 1 Light=
 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Accen=
t 5"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Accen=
t 5"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Accen=
t 5"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dark =
Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"List Table 6 Color=
ful Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"List Table 7 Color=
ful Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"List Table 1 Light=
 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Accen=
t 6"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Accen=
t 6"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Accen=
t 6"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dark =
Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"List Table 6 Color=
ful Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"List Table 7 Color=
ful Accent 6"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Mention"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Smart Hyperlink"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Hashtag"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Unresolved Mention"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Smart Link"/>
</w:LatentStyles>
</xml><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-536869121 1107305727 33554432 0 415 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-469750017 -1073732485 9 0 511 0;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:modern;
	mso-font-pitch:fixed;
	mso-font-signature:-536869121 64767 1 0 415 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}
a:link, span.MsoHyperlink
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:purple;
	text-decoration:underline;
	text-underline:single;}
pre
	{mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-font-family:Calibri;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-unhide:no;
	mso-style-locked:yes;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;
	mso-ascii-font-family:Consolas;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Consolas;
	mso-bidi-font-family:Calibri;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-style-unhide:no;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	mso-style-noshow:yes;
	mso-style-unhide:no;
	mso-ansi-font-size:11.0pt;
	mso-bidi-font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";
	color:windowtext;}
p.msipheader9f8d35bc, li.msipheader9f8d35bc, div.msipheader9f8d35bc
	{mso-style-name:msipheader9f8d35bc;
	mso-style-unhide:no;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	font-size:10.0pt;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 10]><style>/* Style Definitions */
table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman",serif;}
</style><![endif]--><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"tab-interval:.=
5in;word-wrap:break-word">
<div class=3D"WordSection1">
<p class=3D"msipheader9f8d35bc" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-font-family:&quot;Times N=
ew Roman&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-bidi-font-family:&quot;Times New =
Roman&quot;">My editor won&#8217;t let me reply in-line without making it l=
ook like garbage.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-bidi-font-family:&quot;Times New =
Roman&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-bidi-font-family:&quot;Times New =
Roman&quot;">Thanks for the insight, Luben! They&#8217;re all useful points=
, especially the consolidation and relying on the threshold_validation whic=
h has already occurred before we get to this point (which
 I should&#8217;ve checked). <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-bidi-font-family:&quot;Times New =
Roman&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-bidi-font-family:&quot;Times New =
Roman&quot;">And I overdid the transitive multiplication explanation, so I =
wouldn&#8217;t have to answer questions about it later. But your concise co=
mment below pretty much covers things and shouldn&#8217;t
 cause any unnecessary inquiries.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-bidi-font-family:&quot;Times New =
Roman&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-bidi-font-family:&quot;Times New =
Roman&quot;">Kent <o:p>
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-bidi-font-family:&quot;Times New =
Roman&quot;"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-fareast-font-family:&quot;Time=
s New Roman&quot;">From:</span></b><span style=3D"mso-fareast-font-family:&=
quot;Times New Roman&quot;"> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;
<br>
<b>Sent:</b> Wednesday, October 20, 2021 5:48 PM<br>
<b>To:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Cc:</b> Joshi, Mukul &lt;Mukul.Joshi@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/3] drm/amdgpu: Warn when bad pages approaches =
90% threshold<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-font-family:&quot;Times N=
ew Roman&quot;">On 2021-10-20 12:35, Kent Russell wrote:<o:p></o:p></span><=
/p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>Currently dmesg doesn't warn when the number of bad pages approaches t=
he<o:p></o:p></pre>
</blockquote>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-font-family:&quot;Times N=
ew Roman&quot;"><br>
&quot;Currently&quot; is redundant in this sentence as it is already in pre=
sent simple tense.<br>
<br>
<i>Fair point<o:p></o:p></i></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre><o:p>&nbsp;</o:p></pre>
<pre>threshold for page retirement. WARN when the number of bad pages<o:p><=
/o:p></pre>
<pre>is at 90% or greater for easier checks and planning, instead of waitin=
g<o:p></o:p></pre>
<pre>until the GPU is full of bad pages<o:p></o:p></pre>
</blockquote>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-font-family:&quot;Times N=
ew Roman&quot;"><br>
Missing full-stop (period) above.<br>
<br style=3D"mso-special-character:line-break">
<![if !supportLineBreakNewLine]><br style=3D"mso-special-character:line-bre=
ak">
<![endif]><o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre><o:p>&nbsp;</o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Cc: Luben Tuikov <a href=3D"mailto:luben.tuikov@amd.com">&lt;luben.tui=
kov@amd.com&gt;</a><o:p></o:p></pre>
<pre>Cc: Mukul Joshi <a href=3D"mailto:Mukul.Joshi@amd.com">&lt;Mukul.Joshi=
@amd.com&gt;</a><o:p></o:p></pre>
<pre>Signed-off-by: Kent Russell <a href=3D"mailto:kent.russell@amd.com">&l=
t;kent.russell@amd.com&gt;</a><o:p></o:p></pre>
<pre>---<o:p></o:p></pre>
<pre> drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 17 +++++++++++++++++=
<o:p></o:p></pre>
<pre> 1 file changed, 17 insertions(+)<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<o:p></o:p></pre>
<pre>index f4c05ff4b26c..1ede0f0d6f55 100644<o:p></o:p></pre>
<pre>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<o:p></o:p></pre>
<pre>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<o:p></o:p></pre>
<pre>@@ -1071,12 +1071,29 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_e=
eprom_control *control,<o:p></o:p></pre>
<pre> <span style=3D"mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>control-&gt;ras_fri =3D RAS_OFFSET_TO_INDEX(control, hdr-&gt;first_r=
ec_offset);<o:p></o:p></pre>
<pre> <o:p></o:p></pre>
<pre><span style=3D"mso-spacerun:yes">&nbsp;</span><span style=3D"mso-tab-c=
ount:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if (hdr-&gt;header =3D=
=3D RAS_TABLE_HDR_VAL) {<o:p></o:p></pre>
<pre>+<span style=3D"mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>int threshold =3D 0;=
<o:p></o:p></pre>
<pre> <span style=3D"mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>DRM_DEBUG_DRIVER(&qu=
ot;Found existing EEPROM table with %d records&quot;,<o:p></o:p></pre>
<pre> <span style=3D"mso-tab-count:4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span=
 style=3D"mso-spacerun:yes">&nbsp;</span>control-&gt;ras_num_recs);<o:p></o=
:p></pre>
<pre> <span style=3D"mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>res =3D __verify_ras=
_table_checksum(control);<o:p></o:p></pre>
<pre> <span style=3D"mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if (res)<o:p></o:p><=
/pre>
<pre> <span style=3D"mso-tab-count:3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; </span>DRM_ERROR(&quot;RAS table incorrect checksum or=
 error:%d\n&quot;,<o:p></o:p></pre>
<pre> <span style=3D"mso-tab-count:4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span=
 style=3D"mso-spacerun:yes">&nbsp;&nbsp;</span>res);<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+<span style=3D"mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>/* threshold =3D 0 m=
eans that page retirement is disabled, while<o:p></o:p></pre>
<pre>+<span style=3D"mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> * threshold =3D -1 =
means default behaviour<o:p></o:p></pre>
<pre>+<span style=3D"mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> */<o:p></o:p></pre>
<pre>+<span style=3D"mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if (amdgpu_bad_page_=
threshold =3D=3D -1)<o:p></o:p></pre>
<pre>+<span style=3D"mso-tab-count:3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; </span>threshold =3D ras-&gt;bad_page_cnt_threshold;<o=
:p></o:p></pre>
<pre>+<span style=3D"mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>else if (amdgpu_bad_=
page_threshold &gt; 0)<o:p></o:p></pre>
<pre>+<span style=3D"mso-tab-count:3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; </span>threshold =3D amdgpu_bad_page_threshold;<o:p></=
o:p></pre>
</blockquote>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-font-family:&quot;Times N=
ew Roman&quot;"><br>
I believe we don't need this calculation here as it's already been done for=
 us in
<i>amdgpu_ras_validate_threshold()</i>, in amdgpu_ras.c.<br style=3D"mso-sp=
ecial-character:line-break">
<![if !supportLineBreakNewLine]><br style=3D"mso-special-character:line-bre=
ak">
<![endif]><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-font-family:&quot;Times N=
ew Roman&quot;"><br>
I believe you want to use &quot;ras-&gt;bad_page_cnt_threshold&quot; here i=
nstead. For instance of this, see a bit further down in this very function =
this check including the comment, in italics:<br>
<br>
</span><span style=3D"font-family:&quot;Courier New&quot;;mso-fareast-font-=
family:&quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp; } else if (hdr-&gt;h=
eader =3D=3D RAS_TABLE_HDR_BAD &amp;&amp;<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; amdgpu_bad_page_threshol=
d !=3D 0) {<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; res =3D __verify_ras_table_checksum(c=
ontrol);<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; if (res)<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;RA=
S Table incorrect checksum or error:%d\n&quot;,<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp; res);<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; <i>if (ras-&gt;bad_page_cnt_threshold=
 &gt; control-&gt;ras_num_recs) {<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* This means that=
, the threshold was increased since<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* the last t=
ime the system was booted, and now,<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* ras-&gt;ba=
d_page_cnt_threshold - control-&gt;num_recs &gt; 0,<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* so that at=
 least one more record can be saved,<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* before the=
 page count threshold is reached.<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;*/</i></span=
><span style=3D"mso-fareast-font-family:&quot;Times New Roman&quot;"><br>
<br>
And on the &quot;else&quot;, a bit further down, again in italics:<br>
<br>
</span><span style=3D"font-family:&quot;Courier New&quot;;mso-fareast-font-=
family:&quot;Times New Roman&quot;">&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; }=
 else {<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *exceed_err_limit =
=3D true;<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <i>dev_err(adev-&g=
t;dev,<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &quot;RAS records:%d exceed threshold:%d, &quot;<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &quot;maybe retire this GPU?&quot;,<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 control-&gt;ras_num_recs, ras-&gt;bad_page_cnt_threshold);</i><br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; }</span><span style=3D"mso-fareast-fo=
nt-family:&quot;Times New Roman&quot;"><br>
<br>
<br>
See how it says &quot;<i>records exceed threshold</i>&quot;--well, with thi=
s patch you want to say &quot;<i>records exceed
</i>90%<i> of threshold.</i>&quot; :-) So these are the quantities we gauge=
 each other to.<br>
<br>
Clarification on this below.<br>
<br style=3D"mso-special-character:line-break">
<![if !supportLineBreakNewLine]><br style=3D"mso-special-character:line-bre=
ak">
<![endif]><o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre><o:p>&nbsp;</o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+<span style=3D"mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>/* Since multiplcati=
on is transitive, a =3D 9b/10 is the same<o:p></o:p></pre>
<pre>+<span style=3D"mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> * as 10a =3D 9b. Us=
e this for our 90% limit to avoid rounding<o:p></o:p></pre>
<pre>+<span style=3D"mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span> */<o:p></o:p></pre>
</blockquote>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-font-family:&quot;Times N=
ew Roman&quot;"><br>
I really like the format of the comment. But I feel that the comment itself=
 isn't necessary... at least the way it is written (&quot;9b&quot; may mean=
 &quot;9 bits&quot; or &quot;9 binary&quot;. I'd avoid getting into arithme=
tic theory, and remove the comment completely. Anything else (explaining
 the math) really distracts from the real purpose of what we're doing. (Aft=
er all, this is C, not a class on arithmetic--they who can, will figure it =
out.)<br>
<br>
Perhaps something like:<br>
<br>
</span><span style=3D"font-family:&quot;Courier New&quot;;mso-fareast-font-=
family:&quot;Times New Roman&quot;">/* Warn if we get past 90% of the thres=
hold.<br>
&nbsp;*/<br>
</span><span style=3D"mso-fareast-font-family:&quot;Times New Roman&quot;">=
<br style=3D"mso-special-character:line-break">
<![if !supportLineBreakNewLine]><br style=3D"mso-special-character:line-bre=
ak">
<![endif]><o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>+<span style=3D"mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if (threshold &gt; 0=
 &amp;&amp; ((control-&gt;ras_num_recs * 10) &gt;=3D (threshold * 9)))<o:p>=
</o:p></pre>
</blockquote>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-font-family:&quot;Times N=
ew Roman&quot;"><br>
Right, so here perhaps we want to do this instead:<br>
<br>
</span><span style=3D"font-family:&quot;Courier New&quot;;mso-fareast-font-=
family:&quot;Times New Roman&quot;">diff --git a/drivers/gpu/drm/amd/amdgpu=
/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
index 98732518543e53..2aab62fa488eba 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
@@ -1077,6 +1077,12 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_=
control *control,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (res)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&=
quot;RAS table incorrect checksum or error:%d\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Warn if we get past 90% of the threshold.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (10 * control-&gt;ras_num_recs &gt;=3D 9 * ras-&gt;bad_page_c=
nt_threshold)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_WARN(&quot;R=
AS records:%u exceeds 90%% of threshold:%d&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;ras_num_recs,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras-&gt;bad_page_cnt_threshold);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (hdr-&gt;header =3D=3D=
 RAS_TABLE_HDR_BAD &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bad_page_threshold !=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; res =3D __verify_ras_table_checksum(control);<br>
</span><span style=3D"mso-fareast-font-family:&quot;Times New Roman&quot;">=
<br>
Also note that up until this point of the boot process, we don't qualify th=
e boot by amdgpu_bad_page_threshold and I feel that this check in this embe=
dded if-conditional shouldn't do that as well.<br>
<br>
Regards,<br>
Luben<br>
<br style=3D"mso-special-character:line-break">
<![if !supportLineBreakNewLine]><br style=3D"mso-special-character:line-bre=
ak">
<![endif]><o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre><o:p>&nbsp;</o:p></pre>
<pre>+<span style=3D"mso-tab-count:3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; </span>DRM_WARN(&quot;RAS records:%u exceeds 90%% of t=
hreshold:%d&quot;,<o:p></o:p></pre>
<pre>+<span style=3D"mso-tab-count:4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span=
 style=3D"mso-tab-count:1"> </span>control-&gt;ras_num_recs,<o:p></o:p></pr=
e>
<pre>+<span style=3D"mso-tab-count:4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span=
 style=3D"mso-tab-count:1"> </span>threshold);<o:p></o:p></pre>
<pre> <span style=3D"mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>} else if (hdr-&gt;header =3D=3D RAS_TABLE_HDR_BAD &amp;&amp;<o:p></=
o:p></pre>
<pre> <span style=3D"mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style=3D"mso-s=
pacerun:yes">&nbsp;&nbsp;&nbsp;</span>amdgpu_bad_page_threshold !=3D 0) {<o=
:p></o:p></pre>
<pre> <span style=3D"mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>res =3D __verify_ras=
_table_checksum(control);<o:p></o:p></pre>
</blockquote>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-font-family:&quot;Times N=
ew Roman&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB332482A4DC91B5D767744E3485BF9DM6PR12MB3324namp_--
