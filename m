Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE5AC4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 17:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212C920727
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 17:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="tc2fG+tJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212C920727
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A59FF6E177;
	Mon, 26 Oct 2020 17:14:56 +0000 (UTC)
Received: from sonic313-19.consmr.mail.gq1.yahoo.com
 (sonic313-19.consmr.mail.gq1.yahoo.com [98.137.65.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95846E177
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 16:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048;
 t=1603731372; bh=9PK73zWuVX02no22F4RLNCKY01KTFiT0uFO9qKf4YwQ=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject;
 b=tc2fG+tJoQMH+rOHT7AL+cqJrl9qYVJDSGJdTtIha80wnUetf9NWZ9z4P3vzCrE/Z3/gp44oPpIWKpW4gYRJ1US3jT7h8DBn50gVuFVqL70kYC0Yc8kznFrDTVDpwcmwbKGHqTlkd5Y1OwQTrKOZMKezdiGZaXUQWZNctTfKcFqVhtARGIuoMLr9+Qfhot6FED/R074XIiei6ZGpvG6rgwmfLNKhwuHF0+WIKh8R9gTF9dvRasvksY1WOdjx4QYd9F2f2xkmJGLjth8rzK/qGvvusYZbIvSu9hEdVupFMcoeeTINBt52yCaWgSiuNjzKX43MlIBxsWASrpu4wqRlgg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1603731372; bh=cIiOh/gwp34IGmv7ZoG6R94GTQz3ajfFUtbLZiCTk8q=;
 h=Date:From:Subject:To;
 b=ph9KCFah3iZyKQFg5wuTCR2/kXiisiQ7YquBiQ09hrZhEQbbV5c/wZekwQf020eHSD4IO1e1E5u+OqCV/56muNhnj49TtJb8fzazbyjcFAyQB9LiNc2SbVy/6ilnQQnjum+gBDoM9bPIxkgcFSgL+YAkq5QEZZXYlJPl9xalDWONFJqEXc2kGOC8L9w4fSZjILmplCn7vjEB0pDg9wW3dq2ruK8jQKKBJDU5NtyanlfTbkXgeYgK8PiOn1eZvFJzGWx9mQvyQLtMNXDG1SqYJK1MsHszPOZQLOgRZr6ejVnm/JNVdCJO439dxLoU/bssAEzCoKFvEfwQ4w5cE2kKQQ==
X-YMail-OSG: Yne6XSQVM1kO63VDil9UXYKYiaIok9LCgrxQGrwdwAph1zXP8nljL.QwwNDJ6z0
 wXJY7eB3XVlvV1gbKRIJI90qalpxUXfl7Jv_943mWjU5tmLcKSE8UuSE68MbSXaL04.TSnnjzgWi
 ArEQ3VzWNxM1wo394jaj9RlbZkXQ39qoJBYwACWrnrEghCiAG_gkwyYmPqce2p4Dcwyek4wOm.ei
 1SON0a.3FkBvevKVXPoREmvPxh65Y4ZHTvMj99MDITqFibi74pVJXBhcQEQmRnOCpTqbMg2_g5Sf
 nDXqW0J8k3yvbtBms_iD0RlkWKygb2IFBMb4zn9E18kjacXVNHN_vgk24qfUiXHl37K04z25JNDG
 gH_FWlJV8IqoVBLgT5vn0Dd0_53mWf.qrzvoy5af7UwlttE8qUvO95WIz7F4RGR57ZSpfnqsoSY0
 xDcDJu9Rxj2ymy6jKvXMO3rxySHl7Nf6qjVABt_iiFRqnsyINtyk1JkxlT6cwAw_vRRrBQACO_Gw
 621SnVjrYwY65guZjg7prEnJIDcwLU.PryeAqzGeZWJeH1n6VtBnYO4s7rA4Eo7CUaUd5maioIi7
 UW0rMcPuzF78b.2syhuCSfOcn4zoDDDS5d4e8BwM01THemIoTe3SRWVCT7_OStppLNsQfHhrw.Pq
 byFkB1C0nFTnbrFFq11oijan89Rq7kQdTZvpk7cahYVTHrNSCrCFx9QbKNXU.deVyneA8XJrJKGt
 459GPff4Jbg2EABVAsOhcPllQLfPcf0rndULh_2X7bUeg0WpKNfiFbhA_9FZGEYGgr80eXPPYUc_
 hP7j9DwYCpe4mny9brlI4HV1CwyhMarwSJ9M8C4QE5eqYgpJVbWh9PVYF1.4ql.0cvrDPC_TsSrh
 ofwCeks3ONhDwEwwkzMXsJoQgJTL.6levStBeCbEYw2S6YUzrSo0j.z7AipNrpZbaDAO1j8pQ8O7
 AElMqrsaPn3Xhub2Mk7KEynLIsuFN2cLqoHcZK74H8pzDh12UwdmbLbjkCB_pwlDAEPT.b.ghPya
 5bu0yVMA82cksWCQuEEliO7mMrjGD3kL2EyCS9re7_dsPAJniKrO_RKmMBmUSH82EPwIBxCDNUtw
 G91kRDBPgJq5xF636_ydqYInNsbanFFxpFIC7ujP93wIJm0FTR8fARIf35NDx4yiqKgsOFL9molm
 7lmIGI2F5FD4EM9hhg8XPzZCWZCrPUq.C66IUNEtjWq1RSC0cfOoNst_uX70Cd6Tc5PDxTXqmR8n
 Ga.EPeHhhV83SJB5K8.EaQR2nf2cqJzBoYnQd7cHtaJ9jUlpfGdnVIHKnw.eNRMLEfHyGxUNjVpQ
 Nkpmu8UP9zFeTXym60G3c5NtA4DclCOzgsHSWEP4E4pcOiWXYQnY.F0LGhijEHHRoaugiaBLG93u
 qvKX0xENpOIS1eIiGMusuSCtncFHwtWK8pTxhRZNS2L3WYNnONXYl0NZsmklopYSqCdfTvKBJf0j
 rUn0eNje8CeUn7NyoJlk4Q1Z3NxvknNcNgB3eTfY2SSzYtxPx86mZKi7We82LlHj41cFqqD8g_tu
 cJ2OULbruN9v_pROMON5kXvYWrET6psuj.rSHv3JwZnawoT97_UXGkyPHwAYPCVZX2C5lzuIUnjT
 lQUPD6sI1ufc.HF47CJ_n16clJHJWEzYM6O8YMpN9ZmxyixsT2Tr94ArvPkDhQSx4Emt1Fr8SFxP
 F94a6OAH7E5Zw2TF9oK7JhlKJp05HLzjrvcnI0mHC.cgGdGqrsVeQ2DkGJIPeCHRlSjsNWUAjeqb
 _z0GyYQOzkS9NFv8E1xP23uSaNLlUEkL_ZsTRMtQ7v4rF3x1AsP7oD.OQYp3IU39OoAmOD1hw95_
 uTbYUMwvegdjlKGPwh_3Uh8dgkYwDbl0u.VkUaJBWPNQJR708dmthFFhjkbxknShq6XPLLlISCHk
 3hOceLxurGSEB2h9L4WZtjjOAcP.7iITgDlYM9d0KPa8mg1pFeIbX1pa1K6W4uVfH0OaeZsSYm43
 35BavZyhvIWtb9Dp65dZWhxt3cdAH0npR1Yy2gYH2W_1MRf.9e7Guv94nalZY.iaoVi11HTrzFrD
 deP72tyDktQMo_2cDWXWy2xZSYb0RSDIWE6sQhqWBGUjUVSd.ZY645Qn0ewaHIb1P_sujDmbay6H
 RgYtH8dVU1CTCfvn9LF0ZwVWFjd4zA_bxqWIKGA97uKHV.kMpyJWghhDUH6NlmCFMcM6uLUeIfWr
 s1isj.0PczLbwejeAKDXBMy5L5jfYhil_PAV0bhQcZENJ8XIX5FdPhnoa8JdVDHmtuvu_7.WCnGk
 ZR5Pzzke8ERHQ4rsv4lGPEdBZDmSUe902ozdQBG_8xGDP4JlksVvBu.q01Xu9xe1tfI.L.eMnTF7
 WgJCqMoJjPY9W8hA.h1zmHEM_moTKsDtIYj3t36Df7_yalkP436omwzVEMvSneuO3zxXsqFCAilz
 kM1QGrptpPdBh0l6riJOvhsn078XJVIyekadZuNYuke56wTVYZZYXLTRdzMngOb70d.yw37NKU3o
 iCMQGFJKWLdsPSQvhSOj2gQot9PC8qGbzW6AsdGp16dEqhqZE2khGWylpEvybcquJiencghrq156
 jvssDShGCPJdD7w3gemrrSItfOrxHVLgYXgXI04Gv6Sf4cnR7BXYpMT8Aa_Z7AXP7NWJ_wKFcIyr
 WcllU2WdZZXAZrt68hYzbua7rMc_nyF.vCsQgSEq7d9sTee1WQ7vxfe.hHnOUBnc7DXREyxpdw0P
 XOJr.ZS3SnfA1RsTgbZ.31XnT4Xt7OgbhfoPativYc.TQM_uD2hxBHxMd2_GwjvGd9z5UFp4a8gB
 H
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Mon, 26 Oct 2020 16:56:12 +0000
Received: by smtp422.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 79a6ac8080ce1648b51bbf3b1e73ca46; 
 Mon, 26 Oct 2020 16:56:12 +0000 (UTC)
Date: Mon, 26 Oct 2020 12:56:07 -0400
From: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: [PATCH] drm/amdgpu/display: use kvzalloc again in dc_create_state
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201026143040.887736-1-alexander.deucher@amd.com>
In-Reply-To: <20201026143040.887736-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Message-Id: <1603731150.75fg1z8ezy.none@localhost>
X-Mailer: WebService/1.1.16868
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
X-Mailman-Approved-At: Mon, 26 Oct 2020 17:14:54 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aric Cyr <aric.cyr@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Excerpts from Alex Deucher's message of October 26, 2020 10:30 am:
> It looks this was accidently lost in a follow up patch.
> dc context is large and we don't need contiguous pages.
> 
> Fixes: e4863f118a7d ("drm/amd/display: Multi display cause system lag on mode change")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Aric Cyr <aric.cyr@amd.com>
> Cc: Alex Xu <alex_y_xu@yahoo.ca>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 7ff029143722..64da60450fb0 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1564,8 +1564,8 @@ static void init_state(struct dc *dc, struct dc_state *context)
>  
>  struct dc_state *dc_create_state(struct dc *dc)
>  {
> -	struct dc_state *context = kzalloc(sizeof(struct dc_state),
> -					   GFP_KERNEL);
> +	struct dc_state *context = kvzalloc(sizeof(struct dc_state),
> +					    GFP_KERNEL);
>  
>  	if (!context)
>  		return NULL;
> -- 
> 2.25.4
> 
> 

Did a quick test, it seems to resolve the issue for me. If you could 
apply one or both of:

Reported-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
Tested-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>

I'd appreciate it, but it's not a big deal. Thanks!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
